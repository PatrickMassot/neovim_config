(section
  (heading _ (_) @name) 
  (#set! "kind" "Interface")) @symbol

((code)
 (label) @name @symbol 
 (#gsub! @name "<(.*)>" "%1")
 (#set! "kind" "Class")
 ) 
