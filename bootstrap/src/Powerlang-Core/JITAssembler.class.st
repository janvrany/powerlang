Class {
	#name : #JITAssembler,
	#superclass : #Object,
	#instVars : [
		'wordSize',
		'backend'
	],
	#category : #'Powerlang-Core-Assembler'
}

{ #category : #storing }
JITAssembler >> add: source1 to: source2andDest [
	self subclassResponsibility
]

{ #category : #storing }
JITAssembler >> addImm: imm to: dest [
	self subclassResponsibility
]

{ #category : #storing }
JITAssembler >> and: source1andDest with: source2 [
	self subclassResponsibility
]

{ #category : #storing }
JITAssembler >> and: source1andDest withImm: imm [
	self subclassResponsibility
]

{ #category : #storing }
JITAssembler >> andIndirect: source1andDest withImm: imm [
	self subclassResponsibility
]

{ #category : #storing }
JITAssembler >> lea: dest base: base index: index scale: scale [
	self subclassResponsibility
]

{ #category : #loading }
JITAssembler >> load: dstReg fromBase: baseReg index: indexReg [
	self load: dstReg fromBase: baseReg offsetImm: 0 - wordSize index: indexReg scaleImm: wordSize

]

{ #category : #loading }
JITAssembler >> load: dstReg fromBase: baseReg indexImm: index [ 
	self load: dstReg fromBase: baseReg offsetImm: (index - 1) * wordSize

]

{ #category : #loading }
JITAssembler >> load: dstReg fromBase: baseReg offsetImm: offsetInBytes [
	"Load pointer into `dstReg` from memory. The effective address is computed as:

		EA := baseReg + offsetInBytes
	"    
	^ self subclassResponsibility

]

{ #category : #loading }
JITAssembler >> load: dstReg fromBase: baseReg offsetImm: offsetInBytes index: indexReg scaleImm: scaleInBytes [
	"Load pointer into `dstReg` from memory. The effective address is computed as:

		EA := baseReg + offsetInBytes + ((indexReg - 1) * scaleInBytes)
	"    
	^ self subclassResponsibility

]

{ #category : #services }
JITAssembler >> move: srcReg to: dstReg [
	^ self subclassResponsibility

]

{ #category : #private }
JITAssembler >> pop: dstReg [
	"This can be implemented like:

	 self add: self regSP i: wordSize
	 self load: dstReg with: self regSP offset: 0

	 Architectures with specialized push/pop may override
	 this.

	 TODO.
	"
	self error: 'Unfinished, see comment above'

]

{ #category : #private }
JITAssembler >> push: srcReg [
	"This can be implemented like:

	 self store: srcReg with: self regSP offset: 0
	 self sub: self regSP i: wordSize


	 Architectures with specialized push/pop may override
	 this.

	 TODO.
	"
	self error: 'Unfinished, see comment above'

]

{ #category : #'registers - IR' }
JITAssembler >> regA [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regA8 [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regB [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regC [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regE [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regFP [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regFalse [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regG [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regIP [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regM [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regNil [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regR [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regR8 [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regS [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regSP [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regT [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regT8 [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regTrue [
	^ self subclassResponsibility

]

{ #category : #'registers - IR' }
JITAssembler >> regV [
	^ self subclassResponsibility

]

{ #category : #storing }
JITAssembler >> store: srcReg intoBase: baseReg index: indexReg [
	self store: srcReg intoBase: baseReg offsetImm: 0 - wordSize index: indexReg scaleImm: wordSize

]

{ #category : #storing }
JITAssembler >> store: srcReg intoBase: baseReg indexImm: index [ 
	self store: srcReg intoBase: baseReg offsetImm: (index - 1) * wordSize

]

{ #category : #storing }
JITAssembler >> store: srcReg intoBase: baseReg offsetImm: offsetInBytes [
	"Store pointer from `dstReg` into memory. The effective address is computed as:

		EA := baseReg + offsetInBytes
	"    
	^ self subclassResponsibility

]

{ #category : #storing }
JITAssembler >> store: srcReg intoBase: baseReg offsetImm: offsetInBytes index: indexReg scaleImm: scaleInBytes [
	"Store pointer from `dstReg` into memory. The effective address is computed as:

		EA := baseReg + offsetInBytes + ((indexReg - 1) * scaleInBytes)
	"    
	^ self subclassResponsibility

]