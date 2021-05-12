Extension { #name : #InlineMessageLinker }

{ #category : #'*Powerlang-Devtools-SmalltalkX' }
InlineMessageLinker class >> performedSelectors [
	^ self supported collect: [ :assoc | assoc value ]

	"
	self supported
	"

]
