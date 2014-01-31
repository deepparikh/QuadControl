const int analogOutPin = 9; // Analog output pin that the LED is attached to
int outputValue;
int i=0;
void setup() {
  pinMode(13, OUTPUT); 
  
  Serial.begin(9600);
  Serial.println("Wait...");
  delay(10000);
  Serial.println("ESC32 test Start...");
  
  digitalWrite(13,HIGH);
  outputValue = 100;  
  analogWrite(analogOutPin, outputValue); 
  Serial.println("Arm .....");          
  delay(5000);
  
  digitalWrite(13,LOW);
  outputValue = 138;  
  analogWrite(analogOutPin, outputValue); 
  Serial.println("motor start condition .....");          
  delay(5000);
  
  digitalWrite(13,HIGH);
  outputValue = 133;  
  analogWrite(analogOutPin, outputValue);     
  Serial.println("throttle 1 dec.....");      
  delay(5000); 
  
  digitalWrite(13,HIGH);
  outputValue = 128;  
  analogWrite(analogOutPin, outputValue);     
  Serial.println("throttle 2 dec.....");      
  delay(5000);
  
  digitalWrite(13,LOW);
  outputValue = 140;  
  analogWrite(analogOutPin, outputValue);     
  Serial.println("throttle 1 inc.....");      
  delay(5000);
  
  digitalWrite(13,LOW);
  outputValue = 145;  
  analogWrite(analogOutPin, outputValue);     
  Serial.println("throttle 2 inc .....");      
  delay(5000);
  
  digitalWrite(13,LOW);
  outputValue = 150;  
  analogWrite(analogOutPin, outputValue);     
  Serial.println("throttle 3 inc.....");      
  delay(5000);
  
  digitalWrite(13,LOW);
  outputValue = 160;  
  analogWrite(analogOutPin, outputValue);     
  Serial.println("throttle 4 inc.....");      
  delay(5000);
  
  digitalWrite(13,LOW);
  outputValue = 170;  
  analogWrite(analogOutPin, outputValue);     
  Serial.println("throttle 5 inc.....");      
  delay(5000);
  
}

void loop() {

  char ch=Serial.read();
  if(ch=='q'||i==1)
  {
    analogWrite(analogOutPin, outputValue-=10);
    Serial.print("throttle dec.....");
    Serial.println(outputValue);
    delay(500); 
    i=1;
    if(outputValue<10)
    {
      i=0;
    }
  }
  
  if(ch=='i')
  {
    analogWrite(analogOutPin, outputValue+=10);
    Serial.print("throttle inc.....");
    Serial.println(outputValue);
    delay(500); 
  }
  
  if(ch=='d')
  {
    analogWrite(analogOutPin, outputValue-=10);
    Serial.print("throttle dec.....");
    Serial.println(outputValue);
    delay(500); 
  }
}
