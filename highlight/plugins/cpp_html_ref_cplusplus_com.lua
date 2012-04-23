--[[
Sample plugin file for highlight 3.9
]]

Description="Add cplusplus.com reference links to HTML output"

-- optional parameter: syntax description
function syntaxUpdate(desc)
  
  if desc~="C and C++" then
     return
  end
  
  function Set (list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
      return set
  end
  

  function Decorate(token, state, docformat, line, index)
   -- print ("token:"..token)
   -- print ("format" .. docformat)
   -- print ("line:"..line)
   -- print ("index:"..index)
    

    if (docformat ~= HL_FORMAT_HTML and docformat ~= HL_FORMAT_XHTML) then 
      return
    end
    
    if (state ~= HL_STANDARD and state ~= HL_KEYWORD and state ~=HL_PREPROC) then 
      return
    end
    
    local stl_items = Set {"array", "bitset", "deque", "forward_list", "list",
      "map", "multimap", "multiset", "priority_queue", "queue", "set", "stack",
      "unordered_map", "unordered_multimap", "unordered_multiset", "unordered_set",
      "vector" }
    
    local algorithm_items = Set {"adjacent_find", "binary_search", "copy",
      "copy_backward", "count", "count_if", "equal", "equal_range", "fill", "fill_n",
      "find", "find_end", "find_first_of", "find_if", "for_each", "generate",
      "generate_n", "includes", "inplace_merge", "iter_swap",
      "lexicographical_compare", "lower_bound", "make_heap", "max", "max_element",
      "merge", "min", "min_element", "mismatch", "next_permutation", "nth_element",
      "partial_sort", "partial_sort_copy", "partition", "pop_heap",
      "prev_permutation", "push_heap", "random_shuffle", "remove", "remove_copy",
      "remove_copy_if", "remove_if", "replace", "replace_copy", "replace_copy_if",
      "replace_if", "reverse", "reverse_copy", "rotate", "rotate_copy", "search",
      "search_n", "set_difference", "set_intersection", "set_symmetric_difference",
      "set_union", "sort", "sort_heap", "stable_partition", "stable_sort", "swap",
      "swap_ranges", "transform", "unique", "unique_copy", "upper_bound" }
    
    local clib_items = Set {"cassert", "cctype", "cerrno", "cfloat", "ciso646",
      "climits", "clocale", "cmath", "csetjmp", "csignal", "cstdarg", "cstddef",
      "cstdio ", "cstdlib", "cstring", "ctime"}
      
    local iostream_items=Set {
      "filebuf", "fstream", "ifstream", "ios", "iostream", "ios_base", "istream",
      "istringstream", "ofstream", "ostream", "ostringstream", "streambuf",
      "stringbuf", "stringstream", "cerr", "cin", "clog", "cout", "fpos", "streamoff",
      "streampos", "streamsize" 
    }
    url_start="<a class=\"hl\" target=\"new\" href=\"http://www.cplusplus.com/reference/"  
    
    if stl_items[token] then
      return url_start.."stl/".. token .."/\">".. token .. "</a>"
    elseif algorithm_items[token] then
      return url_start.."algorithm/".. token .."/\">".. token .. "</a>"
    elseif clib_items[token] then
      return url_start.."clibrary/".. token .."/\">".. token .. "</a>"
    elseif iostream_items[token] then
      return url_start.."iostream/".. token .."/\">".. token .. "</a>"
    end
    
  end
end

-- function to update theme definition
-- optional parameter: theme description
function themeUpdate(desc)
   -- inherit formatting of enclosing span tags
   Attachment="a.hl {color:inherit;font-weight:inherit;}"
end

--The Plugins array assigns code chunks to themes or language definitions.
--The chunks are interpreted after the theme or lang file were parsed,
--so you can refer to elements of these files

Plugins={

  { Type="lang", Chunk=syntaxUpdate },
  { Type="theme", Chunk=themeUpdate },

}