Extension { #name : #OptimizingBlockInliner }

{ #category : '*Powerlang-Devtools-SmalltalkX' }
OptimizingBlockInliner class >> performedSelectors [
	^ super performedSelectors , 
	  self inliners collect: [ :e | #inline , e capitalized , 'in:' ]

	"
	self supported
	"

]
