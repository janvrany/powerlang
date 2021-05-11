Extension { #name : #OptimizingInstructionFragmenter }

{ #category : '*Powerlang-Devtools-SmalltalkX' }
OptimizingInstructionFragmenter class >> performedSelectors [
	^ super performedSelectors ,
	 (self selectors select: [:e | e startsWith: 'fragment' ])

	"
	self supported
	"

]
