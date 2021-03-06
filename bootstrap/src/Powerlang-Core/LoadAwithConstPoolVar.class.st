Class {
	#name : #LoadAwithConstPoolVar,
	#superclass : #LoadAwithLiteralVar,
	#category : #'Powerlang-Core-Nativization'
}

{ #category : #accessing }
LoadAwithConstPoolVar >> nativizeUsing: anAssembler for: messageNativizer [
	| i |
	i := messageNativizer methodLiteralIndexFrom: index.
	anAssembler loadAwithMindex: i
]
