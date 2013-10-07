function WordCount()
	local whiteSpace = 0;   --number of whitespace chars
	local nonEmptyLine = 0; --number of non blank lines
	local wordCount = 0;    --total number of words
	
	--Calculate whitespace control
	for m in editor:match("\n") do
		whiteSpace = whiteSpace + 1;
	end
	for m in editor:match("\r") do
		whiteSpace = whiteSpace + 1;
	end
	for m in editor:match("\t") do --count tabs
		whiteSpace = whiteSpace + 1;
	end

	--Calculate non-empty lines and word count
	local itt = 0;
	while itt < editor.LineCount do --iterate through each line
		local hasChar, hasNum = 0;
		line = editor:GetLine(itt);
		if line then
			hasAlphaNum = string.find(line,'%w');
		end
		
		if (hasAlphaNum ~= nill) then
			nonEmptyLine = nonEmptyLine + 1;
		end
		
		if line then
			for word in string.gfind(line, "%w+") do wordCount = wordCount + 1 end
		end
		
		itt = itt + 1;
	end
	
	print("----------------------------");
	print("Chars: \t\t\t",(editor.Length) - whiteSpace);
	print("Words: \t\t\t",wordCount);
	print("Lines: \t\t\t",editor.LineCount);
	print("Lines(non-blank): ", nonEmptyLine);
	
end;
