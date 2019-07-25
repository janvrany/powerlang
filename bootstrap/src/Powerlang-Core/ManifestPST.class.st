"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestPST,
	#superclass : #PackageManifest,
	#category : #'Powerlang-Core-Manifest'
}

{ #category : #'code-critics' }
ManifestPST class >> ruleRBCollectionProtocolRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#SmalltalkKernel)) #'2019-05-18T22:56:29.321173-03:00') #(#(#RGClassDefinition #(#ClassDefinition)) #'2019-05-20T12:59:59.672325-03:00') )
]

{ #category : #'code-critics' }
ManifestPST class >> ruleRBIfTrueReturnsRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'Powerlang-Core')) #'2019-07-24T02:26:09.214605-03:00') )
]

{ #category : #'code-critics' }
ManifestPST class >> ruleRBLiteralArrayCharactersRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SmalltalkScanner #isBinary: #false)) #'2019-07-24T02:26:44.802941-03:00') )
]

{ #category : #'code-critics' }
ManifestPST class >> ruleRBNoClassCommentRuleV1FalsePositive [
	^ #(#(#(#RGClassDefinition #(#SExpression)) #'2019-05-26T03:31:15.275028-03:00') )
]

{ #category : #'code-critics' }
ManifestPST class >> ruleRBReturnsIfTrueRuleV1FalsePositive [
	^ #(#(#(#RGPackage #(#'Powerlang-Core')) #'2019-07-24T02:27:55.345612-03:00') )
]

{ #category : #'code-critics' }
ManifestPST class >> ruleRBSearchingLiteralRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SmalltalkScanner #nextColon #false)) #'2019-07-24T02:24:50.040758-03:00') #(#(#RGClassDefinition #(#SmalltalkScanner)) #'2019-07-24T02:27:27.311656-03:00') )
]

{ #category : #'code-critics' }
ManifestPST class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SlotObjectMap #printOn: #false)) #'2019-05-19T00:11:27.865645-03:00') #(#(#RGMetaclassDefinition #(#'HeapModel class' #HeapModel)) #'2019-05-28T11:56:52.832767-03:00') )
]

{ #category : #'code-critics' }
ManifestPST class >> ruleRBTempsReadBeforeWrittenRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#ProjectSpec #load #false)) #'2019-05-22T01:07:44.263209-03:00') )
]

{ #category : #'code-critics' }
ManifestPST class >> ruleRBUsesAddRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#SmalltalkKernel #newSlots #false)) #'2019-05-19T01:27:26.911539-03:00') )
]