css_path = '/home/dan/.elinks/css'

function follow_url_hook (url)
	return string.gsub(url, 'https://duckduckgo.com/l/?kh=-1&uddg=', '')	
end

function ddg_format (html)
	html = string.gsub (html, "<p class='extra'>.-</p>", "", 5)
	html = string.gsub (html, '<p class="extra">.-</p>', "", 5)	
	html = string.gsub (html, '<div class="header">.-</div>', '', 1)
	html = string.gsub (html, "<link.->", "", 5)
	html = string.gsub (html, "<form.-</form>", "", 10)
	html = string.gsub (html, "<table.-</table>", "", 1)
	html = string.gsub (html, "<img.-/>", "", 3)
	html = string.gsub (html, '<div id="did_you_mean">.-</div>', "", 1)
	return html
end

function git_search_format (html)
	html = string.gsub (html, "<link.->", "", 15)
	html = string.gsub (html, '<header.-</header>', '', 1)
	html = string.gsub (html, '<a.-</a>', '', 8)
	return html
end

function git_format (html)
	html = string.gsub (html, "<link.->", "", 15)	
	html = string.gsub (html, '<a.-</a>', '', 7)
	return html
end

function wikipedia_format (html)
	html = string.gsub (html, "<link.->", "", 15)	
	return html
end

function youtube_format (html)
	html = string.gsub (html, 'YouTube', 'StupidTube', 20)
	html = string.gsub (html, '<ytd-masthead.-</ytd-masthead>', "", 1)	
	return html
end

--TODO: Add css visibility support to elinks
--function add_css (html, file)
--	url = 'file://' .. css_path .. '/' .. file .. '.css'
--	link = '<link rel=stylesheet type="text/css" href="' .. url .. '">'
--	html = string.gsub (html, '<head>', '\n<head>' .. link, 1)
--	return html
--end

function pre_format_html_hook (url, html)
	if string.find (url, "duckduckgo", 1, true) then
		return ddg_format (html)
	elseif string.find (url, "github.com/search", 1, true) then
		return git_search_format (html)
	elseif string.find (url, "github.com/", 1, true) then
		return git_format (html)
	elseif string.find (url, "wikipedia.org/wiki/", 1, true) then
		return wikipedia_format (html) 
	elseif string.find (url, "youtube.com/results", 1, true) then
		return youtube_format (html)
	end
	return html
end
