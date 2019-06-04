Class {
	#name : #ClassVarBinding,
	#superclass : #AssociationBinding,
	#category : #'PST-Compiling'
}

{ #category : #'as yet unclassified' }
ClassVarBinding class >> decodeUsing: anAstcodeDecoder [
	^ anAstcodeDecoder decodeClassVar
]

{ #category : #printing }
ClassVarBinding >> printOn: aStream [
	aStream nextPutAll: 'ClassVarId'
]