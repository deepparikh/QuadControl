clear 'all'

h = Aero.Animation;
h.FramesPerSecond = 100;
h.TimeScaling = 50;
idx1 = h.createBody('pa24-250_orange.ac','Ac3d');

%Open serial port for communication with arduino
s = serial('COM3');     %change com port accroding to your connection
set(s,'BaudRate',9600,'DataBits',8,'Parity','none','InputBufferSize',1);
fopen(s)
s.ByteOrder = 'bigEndian';

%Always keep some delay to let arduino boot
pause(0.1);

%Dummy figure to terminate the infinite loop when required
hf=figure

j=1;
t=1;
k=0;
v=0;
interv=100;
%stringr(100,6)= [zeros];
%stringp(100,6)= [zeros];
%stringy(100,6)= [zeros];

newf(10,7)=[zeros]
while 1

    data = fread(s);
    if data =='S' %start byte
         data = fread(s);
            if data == 'T' %start byte                
                %roll angle 
                for i = 1:1:6
                    stringr(j,i)=fread(s);             
                end
                
                
                %pitch angle
                %for i=1:1:6
                %    stringp(j,i)=fread(s);;                 
                %end
                
                %yaw angle
                %for i=1:1:6
                %    stringy(j,i)=fread(s);;                 
                %end
                %convert the recived ascii string into the float numbers
                angle(j,1)=str2num(char(stringr(j,:)))%+(10*rand);      %roll
                %angle(j,2)=str2num(char(stringp(j,:)));      %pitch
                %angle(j,3)=str2num(char(stringy(j,:)));      %yaw
                feed(j,1)=j;
                feed(j,5)=((angle(j,1))*(3.1))/(180);
                feed(j,6)=0
                feed(j,7)=0
                
                %t = t + 1;
                %if t>10
                %   v=v+1;
                %    t=1;
                %end
                %if j>10
                %    for k=1:1:10
                %        newf(k,:)=feed(k+(v-1)+(t-1),:);
                %        newf(k,1)=k;
                %   end
                %h.Bodies{1}.TimeSeriesSource = newf;
                %h.show();
                %h.play();
                 
                %end
                plot (angle(:,1));
                axis ([interv-100, interv , -100 , 100 ]);
                grid
                drawnow ;
            end
    end  
 %set the packet limit to 100
 j=j+1;
 if j>=100
     j=1
     t=1
     clearvars angle string feed ;
     feed(100,7)=[zeros]
 end
   %exit when 'q' key is pressed
    if strcmp(get(hf,'currentcharacter'),'q')
        fclose(s)
        close(hf)
       break
    end
    
   %figure(hf) 
    drawnow
end

close
delete(s)
clear s