; extends

((call_expression) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "markdown")
  (#set! injection.include-children)
  (#match? @injection.content "^md"))

