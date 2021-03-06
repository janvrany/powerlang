Class {
	#name : #ConstantPoolBinding,
	#superclass : #PoolVarBinding,
	#category : #'Powerlang-Core-SCompiler'
}

{ #category : #testing }
ConstantPoolBinding >> canBeAssigned [
	^false
]

{ #category : #testing }
ConstantPoolBinding >> emitLoadAusing: anAstcodeEncoder [
	anAstcodeEncoder encodeLoadAwithConstPoolVar: association value
]

{ #category : #testing }
ConstantPoolBinding >> isConstantBinding [
	^true
]

{ #category : #testing }
ConstantPoolBinding >> literal [
	^association value
]
