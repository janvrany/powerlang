"
Copyright (c) 2020 Aucerna.
    See (MIT) license in root directory.
"
Class {
	#name : #AssemblerAMD64,
	#superclass : #JITAssembler,
	#instVars : [
		'instruction',
		'operands1',
		'operands2',
		'operands3',
		'pointer',
		'immediate',
		'encoder',
		'memory',
		'labels'
	],
	#classVars : [
		'IndexedLabels'
	],
	#pools : [
		'Registers'
	],
	#category : #'Powerlang-Core-Assembler-Intel'
}

{ #category : #initialization }
AssemblerAMD64 class >> growIndexedLabelsTo: anInteger [
	| new |
	new := (IndexedLabels size + 1 to: anInteger)
		collect: [:i | ('@' , i asString) asSymbol].
	IndexedLabels := IndexedLabels , new
]

{ #category : #initialization }
AssemblerAMD64 class >> initialize [
	self initializeIndexedLabels
	
]

{ #category : #initialization }
AssemblerAMD64 class >> initializeIndexedLabels [
	IndexedLabels := #().
	self growIndexedLabelsTo: 100
]

{ #category : #'instance creation' }
AssemblerAMD64 class >> new [
	^super new initialize
]

{ #category : #labels }
AssemblerAMD64 >> @ label [
	self addLabel: label
]

{ #category : #services }
AssemblerAMD64 >> add: op1 to: op2 [
	self assemble: 'add' with: op2 with: op1
]

{ #category : #services }
AssemblerAMD64 >> addImm: imm to: reg [
	imm == 1 ifTrue: [ 
		self assemble: 'inc' with: reg
	] ifFalse: [ 
		imm == -1 ifTrue: [ 
			self assemble: 'dec' with: reg
		] ifFalse: [  
			self assemble: 'add' with: reg withImm: imm
		].
	].

]

{ #category : #labels }
AssemblerAMD64 >> addLabel: aString [
	self addLabel: aString to: self currentAddress
]

{ #category : #labels }
AssemblerAMD64 >> addLabel: label to: location [
	labels at: label put: location
]

{ #category : #accessing }
AssemblerAMD64 >> addressLength [
	^wordSize * 8
]

{ #category : #accessing }
AssemblerAMD64 >> addressSize [
	^wordSize
]

{ #category : #alignment }
AssemblerAMD64 >> alignTo: aNumber [
	| current count |
	current := memory position.
	count := (current alignedTo: aNumber) - current.
	self nop: count
]

{ #category : #services }
AssemblerAMD64 >> and: source1andDest with: source2 [
	self assemble: 'and' with: source1andDest with: source2
]

{ #category : #services }
AssemblerAMD64 >> and: source1andDest withImm: imm [
	self assemble: 'and' with: source1andDest withImm: imm
]

{ #category : #services }
AssemblerAMD64 >> andIndirect: source1andDest withImm: imm [
	pointer
		reset;
		length: self addressLength;
		base: source1andDest.
	self assemble: 'and' with: pointer withImm: imm
]

{ #category : #relocation }
AssemblerAMD64 >> applyFixups [
	memory applyFixupsWith: self
]

{ #category : #basic }
AssemblerAMD64 >> assemble [
	encoder reset; writeEncodingOn: memory
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic [
	instruction mnemonic: mnemonic; operands: #().
	self assemble
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic with: op [
	| op1 |
	op1 := op isInteger ifTrue: [immediate value: op] ifFalse: [op].
	operands1 at: 1 put: op1.
	instruction mnemonic: mnemonic; operands: operands1.
	self assemble
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic with: op1 with: op2 [
	| op |
	op := op2 isInteger ifTrue: [immediate value: op2] ifFalse: [op2].
	operands2
		at: 1 put: op1;
		at: 2 put: op.
	instruction mnemonic: mnemonic; operands: operands2.
	self assemble
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic
with: op1
with: op2
with: op3 [
	| op |
	op := op3 isInteger ifTrue: [immediate value: op3] ifFalse: [op3].
	operands3
		at: 1 put: op1;
		at: 2 put: op2;
		at: 3 put: op.
	instruction mnemonic: mnemonic; operands: operands3.
	self assemble
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic with: op1 withImm64: op2 [
	| v |
	v := self regV.
	self
		assemble: 'mov' with: v with: op2;
		assemble: mnemonic with: op1 with: v
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic with: op1 withImm: imm [
	immediate value: imm.
	(immediate length <= 32 or: [mnemonic = 'mov' and: [op1 class == Register]])
		ifTrue: [self assemble: mnemonic with: op1 with: immediate]
		ifFalse: [self assemble: mnemonic with: op1 withImm64: immediate]
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic withImm64: op1 [
	| v |
	v := self regV.
	self
		assemble: 'mov' with: v with: op1;
		assemble: mnemonic with: v
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic withImm: imm [
	immediate value: imm.
	immediate length <= 32
		ifTrue: [self assemble: mnemonic with: immediate]
		ifFalse: [self assemble: mnemonic withImm64: immediate]
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic withReg: reg index: index [
	pointer
		reset;
		length: self addressLength;
		base: reg;
		displacement: index - 1 * wordSize.
	self assemble: mnemonic with: pointer
]

{ #category : #basic }
AssemblerAMD64 >> assemble: mnemonic
withReg: dst
withReg: src
index: index [
	pointer
		reset;
		length: self addressLength;
		base: src;
		displacement: index - 1 * wordSize.
	self assemble: mnemonic with: dst with: pointer
]

{ #category : #basic }
AssemblerAMD64 >> assembleAddress: mem [
	| address |
	address := mem isInteger ifTrue: [mem] ifFalse: [
		memory addAbsoluteFixup: mem.
		0].
	wordSize = 8
		ifTrue: [memory nextULargePut: address]
		ifFalse: [memory nextULongPut: address]
]

{ #category : #basic }
AssemblerAMD64 >> assembleByte: byte [
	memory nextBytePut: byte
]

{ #category : #basic }
AssemblerAMD64 >> assembleBytes: aByteArray [
	memory nextBytesPut: aByteArray
]

{ #category : #basic }
AssemblerAMD64 >> assembleBytes: aByteArray count: integer [
	1 to: integer do: [:i | memory nextPut: (aByteArray byteAt: i)]

]

{ #category : #accessing }
AssemblerAMD64 >> assembly [
	^memory bytes
]

{ #category : #storing }
AssemblerAMD64 >> at: position putPointer: value [
	| original |
	original := memory position.
	[
		memory position: position.
		wordSize = 8
			ifTrue: [memory nextULargePut: value]
			ifFalse: [memory nextULongPut: value]]
		ensure: [memory position: original]
]

{ #category : #relocation }
AssemblerAMD64 >> baseAddress [
	^memory baseAddress
]

{ #category : #private }
AssemblerAMD64 >> bitLengthOf: anInteger [
	(anInteger between: -16r80 and: 16r7F) ifTrue: [^8].
	(anInteger between: -16r8000 and: 16r7FFF) ifTrue: [^16].
	(anInteger between: -16r80000000 and: 16r7FFFFFFF) ifTrue: [^32].
	(anInteger between: -16r8000000000000000 and: 16r7FFFFFFFFFFFFFFF)
		ifTrue: [^64].
	(anInteger
		between: -16r80000000000000000000000000000000
		and: 16r7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF)
		ifTrue: [^128].
	^nil
]

{ #category : #debugging }
AssemblerAMD64 >> breakpoint [
	self assemble: 'int' with: 3
]

{ #category : #accessing }
AssemblerAMD64 >> bytes [
	^memory bytes
]

{ #category : #accessing }
AssemblerAMD64 >> callIndirectReg: reg [
	pointer reset; length: reg length; base: reg.
	self assemble: 'call' with: pointer
]

{ #category : #calls }
AssemblerAMD64 >> callTo: label [
	self jump: 'call' to: label size: 4
]

{ #category : #accessing }
AssemblerAMD64 >> clearIntegerBit: op1 [
	self and: op1 with: -2
]

{ #category : #accessing }
AssemblerAMD64 >> codeSize [
	^memory codeSize
]

{ #category : #services }
AssemblerAMD64 >> compare: op1 with: op2 [
	self assemble: 'cmp' with: op1 with: op2
]

{ #category : #integers }
AssemblerAMD64 >> convertToNativeInteger: reg [
	self assemble: 'sar' with: reg with: 1
]

{ #category : #integers }
AssemblerAMD64 >> convertToSmallInteger: reg [
	self
		assemble: 'sal' with: reg with: 1;
		assemble: 'inc' with: reg
]

{ #category : #labels }
AssemblerAMD64 >> currentAddress [
	^memory currentAddress
]

{ #category : #services }
AssemblerAMD64 >> exchange: op1 with: op2 [
	self assemble: 'xchg' with: op1 with: op2
]

{ #category : #initialization }
AssemblerAMD64 >> initialize [
	super initialize.
	instruction := ISAInstruction new.
	operands1 := Array new: 1.
	operands2 := Array new: 2.
	operands3 := Array new: 3.
	immediate := ISAImmediate new.
	pointer := MemoryOperand new.
	encoder := instruction encoder.
	labels := Dictionary new: 100.
	memory := RelocatableBuffer new
]

{ #category : #'private - jumps' }
AssemblerAMD64 >> jump: mnemonic to: label size: n [
	| placeholder end |
	placeholder := 1 bitShift: n - 1 * 8.
	self assemble: mnemonic with: placeholder.
	end := memory position.
	memory
		skip: -1;
		nextPut: 0;
		skip: n negated;
		addRelativeFixup: label size: n;
		position: end
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfBelowOrEqualTo: label [
	self nearJump: 'jbe' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfEqualTo: label [
	self nearJump: 'jz' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfGreaterOrEqualSignedTo: label [
	self nearJump: 'jge' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfGreaterSignedTo: label [
	self nearJump: 'jg' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfLessOrEqualSignedTo: label [
	self nearJump: 'jle' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfLessSignedTo: label [
	self nearJump: 'jl' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfNotCarryTo: label [
	self nearJump: 'jnc' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfNotEqualTo: label [
	self nearJump: 'jnz' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfNotOverflowTo: label [
	self nearJump: 'jno' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfNotZeroTo: label [
	self jumpIfNotEqualTo: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfOverflowTo: label [
	self nearJump: 'jo' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfSignTo: label [
	self nearJump: 'js' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpIfZeroTo: label [
	self jumpIfEqualTo: label
]

{ #category : #accessing }
AssemblerAMD64 >> jumpOver: aBlock [
	| label |
	label := self newLabel.
	self jumpTo: label.
	aBlock value.
	self @ label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpTo: label [
	self nearJump: 'jmp' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> jumpToReg: reg [
	self assemble: 'jmp' with: reg
]

{ #category : #integers }
AssemblerAMD64 >> lastEmittedPointer [
	| patch |
	patch := self currentAddress.
	^patch - wordSize
]

{ #category : #accessing }
AssemblerAMD64 >> lea: dest
		base: base
		index: index
		scale: scale [

	pointer
		reset;
		length: self addressLength;
		base: base;
		index: index;
		scale: scale.
	self assemble: 'lea' with: dest with: pointer
]

{ #category : #integers }
AssemblerAMD64 >> leadingRzeroCount [
	"
	lzcnt is a special x64 extension: it puts the REX
	prefix after the first opcode byte. Our x64 
	encoder doesn't support that, so we fix the
	bytes by hand
	"
	| pos |
	pos := self currentAddress.
	self assemble: 'lzcnt' with: self regR with: self regR.
	memory
		writeByte: 16rF3 at: pos;
		writeByte: 16r48 at: pos + 1
]

{ #category : #OBSOLETE }
AssemblerAMD64 >> load: reg1 from: reg2 atIndex: index [
	| offset |
	offset := reg1 offsetOfIndex: index.
	pointer
		reset;
		length: reg1 length;
		base: reg2;
		displacement: offset.
	self assemble: 'mov' with: reg1 with: pointer
]

{ #category : #OBSOLETE }
AssemblerAMD64 >> load: reg1 from: reg2 atIndexAt: reg3 [
		pointer
				reset;
				length: reg1 length;
				base: reg2;
				index: reg3;
				scale: reg1 sizeInBytes;
				displacement: 0 - reg1 sizeInBytes.
		self assemble: 'mov' with: reg1 with: pointer

]

{ #category : #loading }
AssemblerAMD64 >> load: dstReg fromBase: baseReg offsetImm: offsetInBytes [ 
	pointer
		reset;
		length: wordSize * 8;
		base: baseReg;
		displacement: offsetInBytes.
	self 
		assemble: 'mov'
		with: dstReg
		with: pointer

]

{ #category : #loading }
AssemblerAMD64 >> load: dstReg fromBase: baseReg offsetImm: offsetInBytes index: indexReg scaleImm: scaleInBytes [
	pointer
		reset;
		length: wordSize * 8;
		base: baseReg;
		index: indexReg;
		scale: scaleInBytes;
		displacement: offsetInBytes - wordSize.
	self 
		assemble: 'mov'
		with: dstReg
		with: pointer

]

{ #category : #jumps }
AssemblerAMD64 >> load: reg withImmediate: imm [
	self assemble: 'mov' with: reg with: imm
]

{ #category : #storing }
AssemblerAMD64 >> loadZeroExtendByte: reg1 from: reg2 atIndex: index [
	self loadZeroExtendByte: reg1 from: reg2 atOffset: index - 1
]

{ #category : #storing }
AssemblerAMD64 >> loadZeroExtendByte: reg1 from: reg2 atIndexAt: reg3 [
	pointer
		reset;
		length: 8;
		base: reg2;
		index: reg3;
		displacement: -1.
	self assemble: 'movzx' with: reg1 with: pointer
]

{ #category : #storing }
AssemblerAMD64 >> loadZeroExtendByte: reg1 from: reg2 atOffset: offset [
	pointer
		reset;
		length: 8;
		base: reg2;
		displacement: offset.
	self assemble: 'movzx' with: reg1 with: pointer
]

{ #category : #services }
AssemblerAMD64 >> move: srcReg to: dstReg [
	self ASSERT: (srcReg class = Register and: [dstReg class = Register]).
	self assemble: 'mov' with: dstReg with: srcReg

]

{ #category : #'private - jumps' }
AssemblerAMD64 >> nativeCode [
	^ NativeCode new code: memory bytes
]

{ #category : #'private - jumps' }
AssemblerAMD64 >> nearJump: mnemonic to: label [
	self jump: mnemonic to: label size: 4
]

{ #category : #labels }
AssemblerAMD64 >> newLabel [
	| label next |
	next := labels size + 1.
	IndexedLabels size < next ifTrue: [self class growIndexedLabelsTo: next].
	label := IndexedLabels at: next.
	self addLabel: label to: nil.
	^label
]

{ #category : #alignment }
AssemblerAMD64 >> nop [
	self assemble: 'nop'
]

{ #category : #alignment }
AssemblerAMD64 >> nop2 [
	memory nextPutAll: #[16r66 16r90]
]

{ #category : #alignment }
AssemblerAMD64 >> nop3 [
	memory nextPutAll: #[16r0F 16r1F 16r00]
]

{ #category : #alignment }
AssemblerAMD64 >> nop4 [
	memory nextPutAll: #[16r0F 16r1F 16r40 16r00]
]

{ #category : #alignment }
AssemblerAMD64 >> nop5 [
	memory nextPutAll: #[16r0F 16r1F 16r44 16r00 16r00]
]

{ #category : #alignment }
AssemblerAMD64 >> nop6 [
	memory nextPutAll: #[16r66 16r0F 16r1F 16r44 16r00 16r00]
]

{ #category : #alignment }
AssemblerAMD64 >> nop7 [
	memory nextPutAll: #[16r0F 16r1F 16r80 16r00 16r00 16r00 16r00]
]

{ #category : #alignment }
AssemblerAMD64 >> nop8 [
	memory nextPutAll: #[16r0F 16r1F 16r84 16r00 16r00 16r00 16r00 16r00]
]

{ #category : #alignment }
AssemblerAMD64 >> nop9 [
	memory nextPutAll: #[16r66 16r0F 16r1F 16r84 16r00 16r00 16r00 16r00 16r00]
]

{ #category : #alignment }
AssemblerAMD64 >> nop: count [
	"
	ShellDLL current openWebPage: 'http://www.felixcloutier.com/x86/NOP.html'
	"
	| r |
	r := count.
	r >= 9 ifTrue: [
		r // 9 timesRepeat: [self nop9].
		r := r \\ 9].
	r = 8 ifTrue: [^self nop8].
	r = 7 ifTrue: [^self nop7].
	r = 6 ifTrue: [^self nop6].
	r = 5 ifTrue: [^self nop5].
	r = 4 ifTrue: [^self nop4].
	r = 3 ifTrue: [^self nop3].
	r = 2 ifTrue: [^self nop2].
	^self nop
]

{ #category : #calls }
AssemblerAMD64 >> offsetOfIndex: index [
	^index - 1 * wordSize
]

{ #category : #services }
AssemblerAMD64 >> or: op1 with: op2 [
	self assemble: 'or' with: op1 with: op2
]

{ #category : #private }
AssemblerAMD64 >> pop: dstReg [
	self assemble: 'pop' with: dstReg

]

{ #category : #private }
AssemblerAMD64 >> printOn: aStream [
	aStream print: self class; cr; cr;
		nextPutAll: memory bytes disassembledAmd64
]

{ #category : #accessing }
AssemblerAMD64 >> push: srcReg [
	self assemble: 'push' with: srcReg

]

{ #category : #storing }
AssemblerAMD64 >> putPointer: oop at: position [
	| original |
	original := memory position.
	[
		memory position: position.
		wordSize = 8
			ifTrue: [memory nextULargePut: oop]
			ifFalse: [memory nextULongPut: oop]]
		ensure: [memory position: original]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regA [
	^wordSize = 8 ifTrue: [rdx] ifFalse: [edx]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regA8 [
	^dl
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regB [
	^wordSize = 8 ifTrue: [rbx] ifFalse: [ebx]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regC [
	^wordSize = 8 ifTrue: [rbx] ifFalse: [ebx]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regE [
	^wordSize = 8 ifTrue: [rdi] ifFalse: [edi]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regFP [
	^wordSize = 8 ifTrue: [rbp] ifFalse: [ebp]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regFalse [
	^ r14
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regG [
	^r15
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regIP [
	^ rip
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regM [
	^rbx
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regNil [
	^ r12
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regR [
	^wordSize = 8 ifTrue: [rax] ifFalse: [eax]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regR8 [
	^al
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regS [
	^wordSize = 8 ifTrue: [rsi] ifFalse: [esi]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regSP [
	^wordSize = 8 ifTrue: [rsp] ifFalse: [esp]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regT [
	^wordSize = 8 ifTrue: [rcx] ifFalse: [ecx]
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regT8 [
	^ cl
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regTrue [
	^ r13
]

{ #category : #'registers - IR' }
AssemblerAMD64 >> regV [
	^r11
]

{ #category : #relocation }
AssemblerAMD64 >> relocateTo: address [
	| delta |
	delta := address - self baseAddress.
	labels
		keysAndValuesDo: [:label :location | labels
			at: label
			put: location + delta].
	memory relocateTo: address with: self
]

{ #category : #accessing }
AssemblerAMD64 >> renameByteRegisterIfNeeded: register preserving: preserved during: aBlock [
	self
		renameByteRegisterIfNeeded: register
		preserving: preserved
		preserving: nil
		during: aBlock
]

{ #category : #accessing }
AssemblerAMD64 >> renameByteRegisterIfNeeded: register
preserving: preserved1
preserving: preserved2
during: aBlock [
	| final |
	(self addressSize != 4 or: [register byte isLongModeOld8BitRegister not])
		ifTrue: [aBlock value: register]
		ifFalse: [
			final := self renameRegisterPreserving: preserved1 preserving: preserved2.
			self exchange: register e with: final.
			aBlock value: final.
			self exchange: final with: register e]
]

{ #category : #accessing }
AssemblerAMD64 >> renameRegisterPreserving: preserved1 preserving: preserved2 [
	preserved1 == self regR
		ifTrue: [preserved2 == self regA
			ifTrue: [^self regT]
			ifFalse: [^self regA]].
	preserved2 == self regR
		ifTrue: [preserved1 == self regA
			ifTrue: [^self regT]
			ifFalse: [^self regA]].
	^self regR
]

{ #category : #initialization }
AssemblerAMD64 >> reset [
	labels := Dictionary new: 100.
	memory reset
]

{ #category : #labels }
AssemblerAMD64 >> resolveLabel: aString [
	^labels at: aString ifAbsent: [self addressOfExternal: aString]
]

{ #category : #calls }
AssemblerAMD64 >> return [
	self assemble: 'ret'
]

{ #category : #calls }
AssemblerAMD64 >> return: anInteger [
	anInteger = 0
		ifTrue: [self assemble: 'ret']
		ifFalse: [self assemble: 'ret' with: anInteger * self addressSize]
]

{ #category : #accessing }
AssemblerAMD64 >> rotateLeft: op1 count: count [
	self ASSERT: count < 32.
	self assemble: 'rol' with: op1 with: count
]

{ #category : #accessing }
AssemblerAMD64 >> rotateRight: op1 count: count [
	self ASSERT: count < 32.
	self assemble: 'ror' with: op1 with: count
]

{ #category : #accessing }
AssemblerAMD64 >> setIntegerBit: op1 [
	self assemble: 'or' with: op1 with: 1
]

{ #category : #accessing }
AssemblerAMD64 >> shiftLeft: op1 by: count [
	self ASSERT: count < 32.
	self assemble: 'sal' with: op1 with: count
]

{ #category : #accessing }
AssemblerAMD64 >> shiftRight: op1 by: op2 [
	self ASSERT: (op2 isInteger not or: [op2 < op1 length]).
	self assemble: 'sar' with: op1 with: op2
]

{ #category : #'private - jumps' }
AssemblerAMD64 >> shortJump: mnemonic to: label [
	self jump: mnemonic to: label size: 1
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfCarryTo: label [
	self shortJump: 'jc' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfEqualTo: label [
	self shortJump: 'jz' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfLessOrEqualSignedTo: label [
	self shortJump: 'jle' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfLessSignedTo: label [
	self shortJump: 'jl' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfNotCarryTo: label [
	self shortJump: 'jnc' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfNotEqualTo: label [
	self shortJump: 'jnz' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfNotOverflowTo: label [
	self shortJump: 'jno' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfNotZeroTo: label [
	self shortJumpIfNotEqualTo: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfOverflowTo: label [
	self shortJump: 'jo' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfSignTo: label [
	self shortJump: 'js' to: label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpIfZeroTo: label [
	self shortJumpIfEqualTo: label
]

{ #category : #accessing }
AssemblerAMD64 >> shortJumpOver: aBlock [
	| label |
	label := self newLabel.
	self shortJumpTo: label.
	aBlock value.
	self @ label
]

{ #category : #jumps }
AssemblerAMD64 >> shortJumpTo: label [
	self shortJump: 'jmp' to: label
]

{ #category : #OBSOLETE }
AssemblerAMD64 >> store: reg1 in: reg2 index: index [ 
		| offset |
		offset := reg1 offsetOfIndex: index.
		pointer
				reset;
				length: reg1 length;
				base: reg2;
				displacement: offset.
		self assemble: 'mov' with: pointer with: reg1

]

{ #category : #OBSOLETE }
AssemblerAMD64 >> store: op1 in: reg2 indexAt: reg3 [ 
		pointer
				reset;
				length: op1 length;
				base: reg2;
				index: reg3;
				scale: op1 sizeInBytes;
				displacement: 0 - op1 sizeInBytes.
		self assemble: 'mov' with: pointer with: op1

]

{ #category : #storing }
AssemblerAMD64 >> store: srcReg intoBase: baseReg offsetImm: offsetInBytes [ 
	pointer
		reset;
		length: wordSize * 8;
		base: baseReg;
		displacement: offsetInBytes.
	self
		assemble: 'mov'
		with: pointer
		with: srcReg

]

{ #category : #storing }
AssemblerAMD64 >> store: srcReg intoBase: baseReg offsetImm: offsetInBytes index: indexReg scaleImm: scaleInBytes [         
	pointer
		reset;
		length: wordSize * 8;
		base: baseReg;
		index: indexReg;
		scale: scaleInBytes;
		displacement: offsetInBytes - wordSize.
	self
		assemble: 'mov'
		with: pointer
		with: srcReg

]

{ #category : #storing }
AssemblerAMD64 >> storeByte: value in: reg2 index: index [
	self storeByte: value in: reg2 offset: index - 1
]

{ #category : #storing }
AssemblerAMD64 >> storeByte: byte in: reg2 offset: offset [
	pointer
		reset;
		length: 8;
		base: reg2;
		displacement: offset.
	self assemble: 'mov' with: pointer with: byte
]

{ #category : #initialization }
AssemblerAMD64 >> stream [
	^memory stream
]

{ #category : #services }
AssemblerAMD64 >> subtract: op1 from: op2 [
	self assemble: 'sub' with: op2 with: op1
]

{ #category : #services }
AssemblerAMD64 >> testIntegerBit: op1 [
	| op |
	op := op1 byte.
	(self addressSize = 4 and: [op isLongModeOld8BitRegister])
		ifTrue: [op := op1].
	self assemble: 'test' with: op with: 1
]

{ #category : #accessing }
AssemblerAMD64 >> wordSize: anInteger [
	wordSize := anInteger.
	encoder wordSize: anInteger
]

{ #category : #accessing }
AssemblerAMD64 >> wordSizeShift [
	^wordSize = 8 ifTrue: [3] ifFalse: [2]
]