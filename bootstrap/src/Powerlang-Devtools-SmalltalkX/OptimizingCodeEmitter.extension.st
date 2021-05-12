Extension { #name : #OptimizingCodeEmitter }

{ #category : #'*Powerlang-Devtools-SmalltalkX' }
OptimizingCodeEmitter >> assemblers [
	^ assemblers
]

{ #category : #'*Powerlang-Devtools-SmalltalkX' }
OptimizingCodeEmitter class >> performedSelectors [
	| proto |

	proto := self basicNew.
	proto initializeAssemblers.
	^ super performedSelectors ,
	  (proto assemblers values collect: [ :e | (#assemble , e , #'Constant:') ]) ,
	  (proto assemblers values collect: [ :e | (#assemble , e , #':') ])  

	"
	self performedSelectors
	"

]
