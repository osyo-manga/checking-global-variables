scriptencoding utf-8


function! unite#sources#checking_global_variables#define()
	return s:source
endfunction

let s:source = {
\	"name" : "checking-global-variables",
\	"description" : "check global bool variables",
\	"max_candidates" : 30,
\	"default_action" : "change",
\	"action_table" : {
\		"change" : {
\			"description" : "set 0 or 1",
\			"is_selectable" : 1,
\			"is_invalidate_cache" : 1,
\			"is_quit" : 0
\		},
\		"set_0" : {
\			"description" : "set 0",
\			"is_selectable" : 1,
\			"is_invalidate_cache" : 1,
\			"is_quit" : 0
\		},
\		"set_1" : {
\			"description" : "set 1",
\			"is_selectable" : 1,
\			"is_invalidate_cache" : 1,
\			"is_quit" : 0
\		},
\	}
\}


function! s:source.action_table.change.func(candidates)
	for candidate in a:candidates
		let g:[candidate.action__name] = !candidate.action__var
	endfor
endfunction

function! s:source.action_table.set_0.func(candidates)
	for candidate in a:candidates
		let g:[candidate.action__name] = 0
	endfor
endfunction

function! s:source.action_table.set_1.func(candidates)
	for candidate in a:candidates
		let g:[candidate.action__name] = 1
	endfor
endfunction

function! s:source.gather_candidates(args, context)
	return map(items(filter(copy(g:), "self.is_bool(v:val)")), '{
\		"word" : "g:".get(v:val, 0),
\		"abbr" : "[".(get(v:val, 1) ? "x" : " ")."] "."g:".get(v:val, 0),
\		"action__name" : get(v:val, 0),
\		"action__var"  : get(v:val, 1),
\	}')
endfunction

function! s:source.is_bool(value)
	return type(a:value) == type(0) && (a:value == 0 || a:value == 1)
endfunction




