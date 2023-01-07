if exists("b:current_syntax")
    finish
endif 


syntax region tomeComment start="#" end="$"
syntax match tomeIdentifier "^\v-?[a-zA-Z][a-zA-Z0-9_-]*" nextgroup=tomeParameter,tomeDelimiter
syntax match tomeParameter contained "\s*[a-zA-Z][a-zA-Z0-9_-]*" nextgroup=tomeParameter,tomeDelimiter
syntax match tomeDelimiter "\s*=\s*" contained skipnl nextgroup=tomePattern
syntax region tomePattern contained start="" end="\v^(( )@!|( +[\.\[\*\}])@=)" contains=tomeExpressionBlock
syntax region tomeExpressionBlock contained start=+{+ end=+}+ contains=@tomeExpression


syntax cluster tomeKeywords contains=tomeCase,tomeThen,tomeIf,tomeElse
syntax cluster tomeExpression contains=tomeStringExpression,tomeNumberExpression,tomeExpressionIdentifier,@tomeKeywords,tomeVariant,tomeBreak,tomeComment
syntax cluster tomePattern contains=tomeStringExpression,tomeCase,tomeThen,tomeVariant

syntax match tomeExpressionIdentifier contained "\s*-?[a-zA-Z][a-zA-Z0-9_-]*" nextgroup=@tomeExpression
syntax keyword tomeCase case nextgroup=@tomeExpression
syntax keyword tomeThen then nextgroup=@tomeExpression
syntax keyword tomeIf if nextgroup=@tomeExpression
syntax keyword tomeElse else nextgroup=@tomeExpression
syntax match tomeVariant contained "\v\-\>" nextgroup=@tomeExpression
syntax match tomeBreak contained "|"

syntax region tomeStringExpression contained start=+"+ end=+"+
syntax match tomeNumberExpression contained "[0-9]"
syntax match tomeAttribute "@[a-zA-Z][a-zA-Z0-9_-]*"


highlight link tomeComment Comment
highlight link tomeIdentifier Function 
highlight link tomeParameter Identifier 
highlight link tomeExpressionIdentifier Identifier 
highlight link tomePattern String
highlight link tomeStringExpression String
highlight link tomeAttribute Include
highlight link tomeCase Keyword 
highlight link tomeThen Keyword 
highlight link tomeIf Keyword 
highlight link tomeElse Keyword 
highlight link tomeVariant Operator 
highlight link tomeBreak Operator 
highlight link tomeDelimiter Operator 

