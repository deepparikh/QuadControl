%Open serial port for communication with arduino
s = serial('COM3');     %change com port accroding to your connection
set(s,'BaudRate',19200,'DataBits',8,'Parity','none','InputBufferSize',1);
fopen(s)
s.ByteOrder = 'bigEndian';

%Always keep some delay to let arduino boot
pause(0.1);

%Dummy figure to terminate the infinite loop when required
hf=figure; 

j=1;
k=1;
t=1;
interv=1000;
string(100,6)= [zeros];

while 1

    data = fread(s);

    if data =='S' %start byte
         data = fread(s);
            if data == 'T' %start byte
                
                %roll angle 
                for i = 1:1:6
                    data = fread(s);
                    string(j,i)=data;                 
                end
                j = j+1;
                
                %pitch angle
                for i=1:1:6
                    data = fread(s);
                    string(j,i)=data;                 
                end
                j=j+1;
                
                %yaw angle
                for i=1:1:6
                    data = fread(s);
                    string(j,i)=data;                 
                end
            end
    end
    
 %convert the recived ascii string into the float numbers   
 if j>2 
     j=j-2;
     temp=char(string(j,:));
     angle(k,1)=str2num(temp);      %roll
     j=j+1;
     temp=char(string(j,:));
     angle(k,2)=str2num(temp);      %pitch
     j=j+1;
     temp=char(string(j,:));
     angle(k,3)=str2num(temp);      %yaw
     
     
     %plot (angle(:,1));
     %axis ([interv-1000, interv , 100 , 130 ]);
     %grid
     %t = t + 1;
     %drawnow ;
 end

 

 if t== interv
       interv=interv+1000
 end 
   
 %set the packet limit to 100
 j=j+1;
 if j>=100
     j=1
 end
 
 k=k+1;
 if k>=100
     k=1
 end
 
  %exit when 'q' key is pressed
    if strcmp(get(hf,'currentcharacter'),'q')
        fclose(s)
        close(hf)
       break
    end
    
    figure(hf) 
    drawnow
end

close
delete(s)
clear s