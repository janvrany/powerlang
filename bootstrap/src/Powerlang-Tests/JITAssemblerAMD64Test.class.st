Class {
	#name : #JITAssemblerAMD64Test,
	#superclass : #TestCase,
	#instVars : [
		'assembler'
	],
	#category : #'Powerlang-Tests-Assembler-JIT'
}

{ #category : #utilities }
JITAssemblerAMD64Test class >> generateTest: selector [
	| assembler bytes source |
	
	assembler := JITAssemblerAMD64 new wordSize: 8.
	[ 
		assembler perform: selector .
		bytes := assembler bytes.
		bytes isEmpty ifTrue:[ ^ self ].
	] on: Error do:[ ^self ].

	source := 'test<1s>
	
	assembler <2s>.
	self 
		assert: (assembler bytes)
		equals: (<3s>)
	' expandMacrosWith: selector capitalized  with: selector asString with: bytes storeString.
	
	self compile: source classified: #'tests - generated'
	
	"
	self generateTests
	"

	

]

{ #category : #utilities }
JITAssemblerAMD64Test class >> generateTests [
	JITAssemblerAMD64 selectorsDo: [ :sel | sel isUnary ifTrue:[ self generateTest: sel ] ].
]

{ #category : #running }
JITAssemblerAMD64Test >> setUp [
	super setUp.
	assembler := JITAssemblerAMD64 new wordSize: 8.
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testAddAtoR [
	
	assembler addAtoR.
	self 
		assert: (assembler bytes)
		equals: (#[72 1 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testAddDoubleX1toX0 [
	
	assembler addDoubleX1toX0.
	self 
		assert: (assembler bytes)
		equals: (#[242 15 88 193])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testAddSPtoT [
	
	assembler addSPtoT.
	self 
		assert: (assembler bytes)
		equals: (#[72 1 225])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testAddSslotsToSP [
	
	assembler addSslotsToSP.
	self 
		assert: (assembler bytes)
		equals: (#[72 141 36 244])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testAddTslotsToSP [
	
	assembler addTslotsToSP.
	self 
		assert: (assembler bytes)
		equals: (#[72 141 36 204])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testAddTtoR [
	
	assembler addTtoR.
	self 
		assert: (assembler bytes)
		equals: (#[72 1 200])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testAndRwithA [
	
	assembler andRwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 33 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testBuildFrame [
	
	assembler buildFrame.
	self 
		assert: (assembler bytes)
		equals: (#[85 72 137 229])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCallA [
	
	assembler callA.
	self 
		assert: (assembler bytes)
		equals: (#[255 210])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCallIndirectA [
	
	assembler callIndirectA.
	self 
		assert: (assembler bytes)
		equals: (#[255 18])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCallIndirectM [
	
	assembler callIndirectM.
	self 
		assert: (assembler bytes)
		equals: (#[255 19])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCallR [
	
	assembler callR.
	self 
		assert: (assembler bytes)
		equals: (#[255 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testClearAintegerBit [
	
	assembler clearAintegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[72 255 202])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testClearFPUFlags [
	
	assembler clearFPUFlags.
	self 
		assert: (assembler bytes)
		equals: (#[219 226])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testClearRhighHalf [
	
	assembler clearRhighHalf.
	self 
		assert: (assembler bytes)
		equals: (#[137 192])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testClearRintegerBit [
	
	assembler clearRintegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[72 255 200])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testClearSafeRintegerBit [
	
	assembler clearSafeRintegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[36 254])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareAwithFalse [
	
	assembler compareAwithFalse.
	self 
		assert: (assembler bytes)
		equals: (#[76 57 242])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareAwithTrue [
	
	assembler compareAwithTrue.
	self 
		assert: (assembler bytes)
		equals: (#[76 57 234])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareEqualLargeX0withAindirect [
	
	assembler compareEqualLargeX0withAindirect.
	self 
		assert: (assembler bytes)
		equals: (#[242 15 194 2 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareLessThanLargeX0withAindirect [
	
	assembler compareLessThanLargeX0withAindirect.
	self 
		assert: (assembler bytes)
		equals: (#[242 15 194 2 1])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareRwithA [
	
	assembler compareRwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 57 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareRwithFalse [
	
	assembler compareRwithFalse.
	self 
		assert: (assembler bytes)
		equals: (#[76 57 240])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareRwithNil [
	
	assembler compareRwithNil.
	self 
		assert: (assembler bytes)
		equals: (#[76 57 224])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareRwithS [
	
	assembler compareRwithS.
	self 
		assert: (assembler bytes)
		equals: (#[72 57 240])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareRwithTrue [
	
	assembler compareRwithTrue.
	self 
		assert: (assembler bytes)
		equals: (#[76 57 232])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testCompareTwithA [
	
	assembler compareTwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 57 209])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testConvertAtoNativeInteger [
	
	assembler convertAtoNativeInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 250])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testConvertAtoSmallInteger [
	
	assembler convertAtoSmallInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 226 72 255 194])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testConvertRtoNativeInteger [
	
	assembler convertRtoNativeInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testConvertRtoSmallInteger [
	
	assembler convertRtoSmallInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 224 72 255 192])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testConvertTToNativeInteger [
	
	assembler convertTToNativeInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 249])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testConvertTosToSmallInteger [
	
	assembler convertTosToSmallInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 36 36 72 255 4 36])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testConvertTtoNativeInteger [
	
	assembler convertTtoNativeInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 249])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testDecR [
	
	assembler decR.
	self 
		assert: (assembler bytes)
		equals: (#[72 255 200])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testDecRindirect [
	
	assembler decRindirect.
	self 
		assert: (assembler bytes)
		equals: (#[72 255 8])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testDivideDoubleX0byX1 [
	
	assembler divideDoubleX0byX1.
	self 
		assert: (assembler bytes)
		equals: (#[242 15 94 193])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testDivideRbyT [
	
	assembler divideRbyT.
	self 
		assert: (assembler bytes)
		equals: (#[72 153 72 247 249])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testDropTopOfFPU [
	
	assembler dropTopOfFPU.
	self 
		assert: (assembler bytes)
		equals: (#[221 216])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testEnsureRintegerBit [
	
	assembler ensureRintegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[12 1])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testEnsureSafeRintegerBit [
	
	assembler ensureSafeRintegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[12 1])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testExchangeRindirectWithT [
	
	assembler exchangeRindirectWithT.
	self 
		assert: (assembler bytes)
		equals: (#[72 135 8])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testIncA [
	
	assembler incA.
	self 
		assert: (assembler bytes)
		equals: (#[72 255 194])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testIncC [
	
	assembler incC.
	self 
		assert: (assembler bytes)
		equals: (#[72 255 195])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testInitializeS [
	
	assembler initializeS.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 198])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testJumpIndirectA [
	
	assembler jumpIndirectA.
	self 
		assert: (assembler bytes)
		equals: (#[255 34])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testJumpToA [
	
	assembler jumpToA.
	self 
		assert: (assembler bytes)
		equals: (#[255 226])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testJumpToS [
	
	assembler jumpToS.
	self 
		assert: (assembler bytes)
		equals: (#[255 230])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLabeledIntegerBitTestOfA [
	
	assembler labeledIntegerBitTestOfA.
	self 
		assert: (assembler bytes)
		equals: (#[246 194 1 116 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLabeledIntegerBitTestOfR [
	
	assembler labeledIntegerBitTestOfR.
	self 
		assert: (assembler bytes)
		equals: (#[168 1 116 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLabeledIntegerBitTestOfT [
	
	assembler labeledIntegerBitTestOfT.
	self 
		assert: (assembler bytes)
		equals: (#[246 193 1 116 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLabeledIntegerNativizationOfA [
	
	assembler labeledIntegerNativizationOfA.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 250 115 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLabeledIntegerNativizationOfR [
	
	assembler labeledIntegerNativizationOfR.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 248 115 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLabeledIntegerNativizationOfT [
	
	assembler labeledIntegerNativizationOfT.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 249 115 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLabeledNonIntegerBitTestOfR [
	
	assembler labeledNonIntegerBitTestOfR.
	self 
		assert: (assembler bytes)
		equals: (#[168 1 117 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadAwithFalse [
	
	assembler loadAwithFalse.
	self 
		assert: (assembler bytes)
		equals: (#[76 137 242])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadAwithNil [
	
	assembler loadAwithNil.
	self 
		assert: (assembler bytes)
		equals: (#[76 137 226])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadAwithR [
	
	assembler loadAwithR.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 194])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadAwithRoffsetAtA [
	
	assembler loadAwithRoffsetAtA.
	self 
		assert: (assembler bytes)
		equals: (#[72 139 20 16])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadAwithS [
	
	assembler loadAwithS.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 242])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadAwithT [
	
	assembler loadAwithT.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 202])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadAwithTrue [
	
	assembler loadAwithTrue.
	self 
		assert: (assembler bytes)
		equals: (#[76 137 234])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadEwithAddressOfRatA [
	
	assembler loadEwithAddressOfRatA.
	self 
		assert: (assembler bytes)
		equals: (#[72 141 124 208 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadEwithNil [
	
	assembler loadEwithNil.
	self 
		assert: (assembler bytes)
		equals: (#[76 137 231])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadEwithR [
	
	assembler loadEwithR.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 199])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadFPwithR [
	
	assembler loadFPwithR.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 197])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadFPwithSP [
	
	assembler loadFPwithSP.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 229])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadLargeX0withRindirect [
	
	assembler loadLargeX0withRindirect.
	self 
		assert: (assembler bytes)
		equals: (#[102 72 15 110 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadLargeX1withAindirect [
	
	assembler loadLargeX1withAindirect.
	self 
		assert: (assembler bytes)
		equals: (#[102 72 15 110 10])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadLongRWithRAtOffsetA [
	
	assembler loadLongRWithRAtOffsetA.
	self 
		assert: (assembler bytes)
		equals: (#[139 4 16])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadLongRwithRatOffsetA [
	
	assembler loadLongRwithRatOffsetA.
	self 
		assert: (assembler bytes)
		equals: (#[139 4 16])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadMXCSRfromA [
	
	assembler loadMXCSRfromA.
	self 
		assert: (assembler bytes)
		equals: (#[15 174 18])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadMwithA [
	
	assembler loadMwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 211])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRConvertingDoubleRindirect [
	
	assembler loadRConvertingDoubleRindirect.
	self 
		assert: (assembler bytes)
		equals: (#[242 72 15 44 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRconvertingDoublePointedByR [
	
	assembler loadRconvertingDoublePointedByR.
	self 
		assert: (assembler bytes)
		equals: (#[242 72 15 44 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithA [
	
	assembler loadRwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithArgPointer [
	
	assembler loadRwithArgPointer.
	self 
		assert: (assembler bytes)
		equals: (#[72 141 69 16])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithE [
	
	assembler loadRwithE.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithFP [
	
	assembler loadRwithFP.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 232])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithFalse [
	
	assembler loadRwithFalse.
	self 
		assert: (assembler bytes)
		equals: (#[76 137 240])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithM [
	
	assembler loadRwithM.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 216])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithNil [
	
	assembler loadRwithNil.
	self 
		assert: (assembler bytes)
		equals: (#[76 137 224])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithRatA [
	
	assembler loadRwithRatA.
	self 
		assert: (assembler bytes)
		equals: (#[72 139 68 208 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithRatOffsetA [
	
	assembler loadRwithRatOffsetA.
	self 
		assert: (assembler bytes)
		equals: (#[72 139 4 16])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithS [
	
	assembler loadRwithS.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 240])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithSP [
	
	assembler loadRwithSP.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 224])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithT [
	
	assembler loadRwithT.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 200])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithTIBatIndexR [
	
	assembler loadRwithTIBatIndexR.
	self 
		assert: (assembler bytes)
		equals: (#[101 72 139 4 197 0 0 0 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithThreadVariableAtIndexR [
	
	assembler loadRwithThreadVariableAtIndexR.
	self 
		assert: (assembler bytes)
		equals: (#[101 72 139 4 197 128 20 0 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithTos [
	
	assembler loadRwithTos.
	self 
		assert: (assembler bytes)
		equals: (#[72 139 4 36])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithTrue [
	
	assembler loadRwithTrue.
	self 
		assert: (assembler bytes)
		equals: (#[76 137 232])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadRwithX0 [
	
	assembler loadRwithX0.
	self 
		assert: (assembler bytes)
		equals: (#[102 72 15 126 192])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadSPwithFP [
	
	assembler loadSPwithFP.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 236])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadSPwithT [
	
	assembler loadSPwithT.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 204])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadSwithA [
	
	assembler loadSwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 214])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadSwithAddressOfSatA [
	
	assembler loadSwithAddressOfSatA.
	self 
		assert: (assembler bytes)
		equals: (#[72 141 116 214 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadSwithNil [
	
	assembler loadSwithNil.
	self 
		assert: (assembler bytes)
		equals: (#[76 137 230])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadSwithT [
	
	assembler loadSwithT.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 206])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadTwithA [
	
	assembler loadTwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 209])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadTwithR [
	
	assembler loadTwithR.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 193])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadX0withRasDouble [
	
	assembler loadX0withRasDouble.
	self 
		assert: (assembler bytes)
		equals: (#[242 72 15 42 192])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadX1roundingX0 [
	
	assembler loadX1roundingX0.
	self 
		assert: (assembler bytes)
		equals: (#[102 15 58 11 200 3])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadZeroExtendByteRwithRatA [
	
	assembler loadZeroExtendByteRwithRatA.
	self 
		assert: (assembler bytes)
		equals: (#[72 15 182 68 16 255])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadZeroExtendByteRwithSPatA [
	
	assembler loadZeroExtendByteRwithSPatA.
	self 
		assert: (assembler bytes)
		equals: (#[72 15 182 68 20 255])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLoadZeroExtendLongRwithRatA [
	
	assembler loadZeroExtendLongRwithRatA.
	self 
		assert: (assembler bytes)
		equals: (#[139 68 144 252])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testLock [
	
	assembler lock.
	self 
		assert: (assembler bytes)
		equals: (#[240])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testMoveTslots [
	
	assembler moveTslots.
	self 
		assert: (assembler bytes)
		equals: (#[243 72 165])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testMultiplyDoubleX0byX1 [
	
	assembler multiplyDoubleX0byX1.
	self 
		assert: (assembler bytes)
		equals: (#[242 15 89 193])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testMultiplyRbyA [
	
	assembler multiplyRbyA.
	self 
		assert: (assembler bytes)
		equals: (#[72 247 234])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testOrRwithA [
	
	assembler orRwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 9 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopA [
	
	assembler popA.
	self 
		assert: (assembler bytes)
		equals: (#[90])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopB [
	
	assembler popB.
	self 
		assert: (assembler bytes)
		equals: (#[91])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopE [
	
	assembler popE.
	self 
		assert: (assembler bytes)
		equals: (#[95])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopFP [
	
	assembler popFP.
	self 
		assert: (assembler bytes)
		equals: (#[93])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopFalse [
	
	assembler popFalse.
	self 
		assert: (assembler bytes)
		equals: (#[65 94])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopG [
	
	assembler popG.
	self 
		assert: (assembler bytes)
		equals: (#[65 95])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopM [
	
	assembler popM.
	self 
		assert: (assembler bytes)
		equals: (#[91])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopNil [
	
	assembler popNil.
	self 
		assert: (assembler bytes)
		equals: (#[65 92])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopR [
	
	assembler popR.
	self 
		assert: (assembler bytes)
		equals: (#[88])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopS [
	
	assembler popS.
	self 
		assert: (assembler bytes)
		equals: (#[94])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopSP [
	
	assembler popSP.
	self 
		assert: (assembler bytes)
		equals: (#[92])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopSPindirect [
	
	assembler popSPindirect.
	self 
		assert: (assembler bytes)
		equals: (#[143 4 36])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopT [
	
	assembler popT.
	self 
		assert: (assembler bytes)
		equals: (#[89])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPopTrue [
	
	assembler popTrue.
	self 
		assert: (assembler bytes)
		equals: (#[65 93])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushA [
	
	assembler pushA.
	self 
		assert: (assembler bytes)
		equals: (#[82])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushB [
	
	assembler pushB.
	self 
		assert: (assembler bytes)
		equals: (#[83])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushE [
	
	assembler pushE.
	self 
		assert: (assembler bytes)
		equals: (#[87])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushFP [
	
	assembler pushFP.
	self 
		assert: (assembler bytes)
		equals: (#[85])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushFalse [
	
	assembler pushFalse.
	self 
		assert: (assembler bytes)
		equals: (#[65 86])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushG [
	
	assembler pushG.
	self 
		assert: (assembler bytes)
		equals: (#[65 87])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushIndirectR [
	
	assembler pushIndirectR.
	self 
		assert: (assembler bytes)
		equals: (#[255 48])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushM [
	
	assembler pushM.
	self 
		assert: (assembler bytes)
		equals: (#[83])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushNil [
	
	assembler pushNil.
	self 
		assert: (assembler bytes)
		equals: (#[65 84])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushR [
	
	assembler pushR.
	self 
		assert: (assembler bytes)
		equals: (#[80])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushS [
	
	assembler pushS.
	self 
		assert: (assembler bytes)
		equals: (#[86])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushSP [
	
	assembler pushSP.
	self 
		assert: (assembler bytes)
		equals: (#[84])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushT [
	
	assembler pushT.
	self 
		assert: (assembler bytes)
		equals: (#[81])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testPushTrue [
	
	assembler pushTrue.
	self 
		assert: (assembler bytes)
		equals: (#[65 85])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testReadFPUStatusOnA [
	
	assembler readFPUStatusOnA.
	self 
		assert: (assembler bytes)
		equals: (#[155 221 58])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testRestoreCallerEnvironment [
	
	assembler restoreCallerEnvironment.
	self 
		assert: (assembler bytes)
		equals: (#[72 139 125 232])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testRestoreCallerFrame [
	
	assembler restoreCallerFrame.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 236 93])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testRestoreCallerM [
	
	assembler restoreCallerM.
	self 
		assert: (assembler bytes)
		equals: (#[72 139 93 240])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testRestoreCallerSelf [
	
	assembler restoreCallerSelf.
	self 
		assert: (assembler bytes)
		equals: (#[72 139 117 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testRestoreRSmallInteger [
	
	assembler restoreRSmallInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testRestoreRsmallInteger [
	
	assembler restoreRsmallInteger.
	self 
		assert: (assembler bytes)
		equals: (#[72 209 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testSaveCallerFrame [
	
	assembler saveCallerFrame.
	self 
		assert: (assembler bytes)
		equals: (#[85 72 137 229])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testShiftLeftRwithT [
	
	assembler shiftLeftRwithT.
	self 
		assert: (assembler bytes)
		equals: (#[72 211 224])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testShiftRightRwithT [
	
	assembler shiftRightRwithT.
	self 
		assert: (assembler bytes)
		equals: (#[72 211 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testSqrtDoubleX0 [
	
	assembler sqrtDoubleX0.
	self 
		assert: (assembler bytes)
		equals: (#[242 15 81 192])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreAinSPatT [
	
	assembler storeAinSPatT.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 84 204 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreAinThreadVariableAtIndexR [
	
	assembler storeAinThreadVariableAtIndexR.
	self 
		assert: (assembler bytes)
		equals: (#[101 72 137 20 197 128 20 0 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreArgumentsInStack [
	
	assembler storeArgumentsInStack.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 77 16 72 137 85 24 76 137 69 32 76 137 77 40])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreByteTinRatA [
	
	assembler storeByteTinRatA.
	self 
		assert: (assembler bytes)
		equals: (#[136 76 16 255])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreDoubleResultInRindirect [
	
	assembler storeDoubleResultInRindirect.
	self 
		assert: (assembler bytes)
		equals: (#[102 72 15 126 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreLargeX0inA [
	
	assembler storeLargeX0inA.
	self 
		assert: (assembler bytes)
		equals: (#[102 72 15 126 2])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreLargeX0inR [
	
	assembler storeLargeX0inR.
	self 
		assert: (assembler bytes)
		equals: (#[102 72 15 126 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreLargeX0inT [
	
	assembler storeLargeX0inT.
	self 
		assert: (assembler bytes)
		equals: (#[102 72 15 126 1])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreLongTInRAtA [
	
	assembler storeLongTInRAtA.
	self 
		assert: (assembler bytes)
		equals: (#[137 76 144 252])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreLongTinRatA [
	
	assembler storeLongTinRatA.
	self 
		assert: (assembler bytes)
		equals: (#[137 76 144 252])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreLongTinRatOffsetA [
	
	assembler storeLongTinRatOffsetA.
	self 
		assert: (assembler bytes)
		equals: (#[137 12 16])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreMXCSRintoA [
	
	assembler storeMXCSRintoA.
	self 
		assert: (assembler bytes)
		equals: (#[15 174 26])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreShortTinRatOffsetA [
	
	assembler storeShortTinRatOffsetA.
	self 
		assert: (assembler bytes)
		equals: (#[102 137 12 16])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreTIBwithAatIndexR [
	
	assembler storeTIBwithAatIndexR.
	self 
		assert: (assembler bytes)
		equals: (#[101 72 137 20 197 0 0 0 0])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreTInRAtA [
	
	assembler storeTInRAtA.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 76 208 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreTinRatA [
	
	assembler storeTinRatA.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 76 208 248])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testStoreTinRatOffsetA [
	
	assembler storeTinRatOffsetA.
	self 
		assert: (assembler bytes)
		equals: (#[72 137 12 16])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testSubAfromR [
	
	assembler subAfromR.
	self 
		assert: (assembler bytes)
		equals: (#[72 41 208])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testSubAfromT [
	
	assembler subAfromT.
	self 
		assert: (assembler bytes)
		equals: (#[72 41 209])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testSubDoubleX1fromX0 [
	
	assembler subDoubleX1fromX0.
	self 
		assert: (assembler bytes)
		equals: (#[242 15 92 193])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testSubTfromR [
	
	assembler subTfromR.
	self 
		assert: (assembler bytes)
		equals: (#[72 41 200])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testSubTslotsToSP [
	
	assembler subTslotsToSP.
	self 
		assert: (assembler bytes)
		equals: (#[72 247 217 72 141 36 204 72 247 217])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testTestAintegerBit [
	
	assembler testAintegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[246 194 1])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testTestRintegerBit [
	
	assembler testRintegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[168 1])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testTestRwithR [
	
	assembler testRwithR.
	self 
		assert: (assembler bytes)
		equals: (#[72 133 192])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testTestTIntegerBit [
	
	assembler testTIntegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[246 193 1])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testTestTintegerBit [
	
	assembler testTintegerBit.
	self 
		assert: (assembler bytes)
		equals: (#[246 193 1])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testWriteTslots [
	
	assembler writeTslots.
	self 
		assert: (assembler bytes)
		equals: (#[243 72 171])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testXorAwithR [
	
	assembler xorAwithR.
	self 
		assert: (assembler bytes)
		equals: (#[72 49 194])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testXorFPwithFP [
	
	assembler xorFPwithFP.
	self 
		assert: (assembler bytes)
		equals: (#[72 49 237])
	
]

{ #category : #'tests - generated' }
JITAssemblerAMD64Test >> testXorRwithA [
	
	assembler xorRwithA.
	self 
		assert: (assembler bytes)
		equals: (#[72 49 208])
	
]
