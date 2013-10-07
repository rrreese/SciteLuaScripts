function reformatXML()
    editor:BeginUndoAction()
        --Format
        
        for m in editor:match("\r") do --remove carriage returns
          m:replace("")
        end
        for m in editor:match("\t") do --remove tabs
          m:replace("")
        end
        for m in editor:match("\n") do --remove newlines
          m:replace("")
        end
        for m in editor:match("<") do --make each tag use 1 line- text only lines invluded
          m:replace("\n<")
        end
        for m in editor:match(">") do --make each tag use 1 line
          m:replace(">\n")
        end
        for m in editor:match("\n\n") do --make each tag use 1 line
          m:replace("\n")
        end
        --tabify
        
        local tabLevel = 1
        local tempCount = 1
        local itt = 1
        local length = 1
     
        --count number of lines
        for m in editor:match("\n") do --each newline increment length
            length = length + 1
        end
         
        
        body = ""--have to do this
        line = ""--to avoid comparing to empty strings
        
        while itt < length do --length do
            line = editor:GetLine(itt)
            offSet = 0
            if line then --line not null (i think)
                
                tempCount = tabLevel 
                tabify = "" --number of tabs
                while tempCount > 1 do --generate line of tabs
                    tabify = tabify.."\t"
                    tempCount = tempCount - 1
                end
                tabifyE = ""--number of tabs for </
                tempCount = tabLevel + offSet
                while tempCount > 2 do  --generate line of tabs
                    tabifyE = tabifyE.."\t"
                    tempCount = tempCount - 1
                end
                
                if string.find(line,"/>") then --<tag/>
                    line = tabify .. line
                elseif string.find(line,"?>") then --<?xml> Wierdness
                    line = tabify .. line
                elseif string.find(line,"</") then --</tag>
                    tabLevel=tabLevel - 1
                    line = tabifyE .. line
                elseif string.find(line,"<!") then --<!-- Or <![[CDATA
                    line = tabify .. line
                elseif string.find(line,"<") then --<tag>
                    tabLevel=tabLevel + 1 
                    line = tabify .. line    
                else                                --Plain Text
                    line = tabify .. line
                end 
                
                body = body .. line --append line to body
                
            end
            itt = itt + 1 --increment iterator
            
        end
        editor:ClearAll() --Clear old text
        editor:AppendText(body) --Add new text
        
    editor:EndUndoAction()
end
