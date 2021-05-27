Class {
	#name : #TemplateAssembler64Test,
	#superclass : #JITAssembler64Test,
	#category : #'Powerlang-Tests-Assembler-JIT'
}

{ #category : #running }
TemplateAssembler64Test >> setUp [
	super setUp.
	assembler := TemplateAssembler64 new wordSize: 8.
	
]
