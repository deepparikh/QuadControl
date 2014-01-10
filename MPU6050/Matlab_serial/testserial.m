s = serial('COM10');
set(s,'BaudRate',19200,'DataBits',8,'Parity','none','InputBufferSize',1);
fopen(s)
s.ByteOrder = 'bigEndian';

hf=figure('position',[0 0 eps eps],'menubar','none'); 
j=1;
string(100,6)= [zeros]
while 1
data = fread(s);

if data =='S'
     data = fread(s);
        if data=='T'
            for i=1:1:6
                data = fread(s);
                string(j,i)=data;                 
            end   
        end
 end
 temp=char(string(j,:));
 angle(j,1)=str2num(temp);
 j=j+1;
 if j>100
     j=1
 end    
     

    if strcmp(get(hf,'currentcharacter'),'q')
        fclose(s)
        close(hf)
       break
    end
    figure(hf) 
    drawnow
end


delete(s)
clear s