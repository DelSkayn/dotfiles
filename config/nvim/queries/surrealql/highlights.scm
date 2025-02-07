(doc_single_line_comment) @comment
(single_line_comment) @comment
(doc_multi_line_comment) @comment
(multi_line_comment) @comment

(plain_strand) @string
(record_strand) @string.special
(datetime_strand) @string.special
(uuid_strand) @string.special
(regex) @string.regexp
(number) @number
(integer) @number
(duration) @number
(param) @variable.parameter

(kind ("LIKEKW" @type))
(record_id) @variable.member

(defined_function_name) @function
(builtin_function_name) @function.builtin
(constant) @constant.builtin
(dot_operator (identifier) @property)
(destructure_field (identifier) @property)
(object_key (identifier) @property) 


"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
"[" @punctuation.bracket
"]" @punctuation.bracket
"|" @punctuation.bracket
(cast_operator ("<" @punctuation.bracket))
(cast_operator (">" @punctuation.bracket))
(kind ("<" @punctuation.bracket))
(kind (">" @punctuation.bracket))

";" @punctuation.delimiter
":" @punctuation.delimiter

(null) @constant.builtin
(none) @constant.builtin
(boolean) @boolean
  
(range_operator) @operator
(prefix_operator) @operator
(or_operator) @operator
(add_operator) @operator
(and_operator) @operator
(eq_operator) @operator
(mull_operator) @operator
(relation_operator) @operator
(knn_operator) @operator
(graph_operator_token) @operator
(assign_operator) @operator

"**" @operator
"*" @operator
"->" @operator

"KW" @keyword
