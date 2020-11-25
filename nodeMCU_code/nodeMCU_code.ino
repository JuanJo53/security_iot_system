#include <ESP8266WiFi.h>
#include <Servo.h>

#define WIFI_SSID "Batcave"
#define WIFI_PASSWORD "78312bea"

const char auth[] = "QWI85H-jllIzyH1nTr2rqSH-njVuciR0";
const char* host = "blynk-cloud.com";
unsigned int port = 8080;
WiFiClient client;

#define pinRele1 D3
#define pinRele2 D4

int pinR=D0;
int pinG=D1;
int pinB=D2;
int pinPIR=D5;
int pinBuzzer=D6;
int pinMotor1=D7;
int pinMotor2=D8;

void setup(){
  Serial.begin(115200);

  
  pinMode(pinR,OUTPUT);
  pinMode(pinG,OUTPUT);
  pinMode(pinB,OUTPUT);
  pinMode(pinPIR,INPUT);
  pinMode(pinRele1,OUTPUT);
  pinMode(pinRele2,OUTPUT);  
  pinMode(pinMotor1,OUTPUT);
  pinMode(pinMotor2,OUTPUT);
  pinMode(pinBuzzer, OUTPUT);
  
  connectNetwork();
}
void loop(){  
  //Setting Red pin value from API
  int rPinStatus=readIntValue("V0");  //V0: pin Red of LED RGB
  //Serial.print("LED rojo: ");Serial.println(rPinStatus);
  analogWrite(pinR, rPinStatus);
  
  //Setting Green pin value from API
  int gPinStatus=readIntValue("V1");  //V1: pin Green of LED RGB
  Serial.print("LED verde: ");Serial.println(gPinStatus);
  analogWrite(pinG, gPinStatus);
  
  //Setting Blue pin value from API
  int bPinStatus=readIntValue("V2");  //V2: pinB Blue of LED RGB
  Serial.print("LED azul: ");Serial.println(bPinStatus);
  analogWrite(pinB, bPinStatus);

  //Setting Room1 light value from API
  int room1Status=readIntValue("V3"); //V3: pinRele1 of Room 1
  Serial.print("Foco 1: ");Serial.println(room1Status);
  if(room1Status==0){
    controlRoom(pinRele1,HIGH);
  }else{
    controlRoom(pinRele1,LOW);
  }
  //Setting Room2 light value from API  
  int room2Status=readIntValue("V4"); //V4: pinRele1 of Room 2
  Serial.print("Foco 2: ");Serial.println(room2Status);
  if(room2Status==0){
    controlRoom(pinRele2,HIGH);
  }else{
    controlRoom(pinRele2,LOW);
  }

  //Writting temperature value to API
  float temp=getLM35data();           //Gets temperature in °C value from LM35
  putValue(String(temp),"A0");
  Serial.print("Temperatura desde server: ");Serial.println(readFloatValue("A0"));

  //Writting PIR status value to API
  int pirState=getPIRdata();          //Gets PIR sensor status  
  putValue(String(pirState),"V5");
  Serial.println(readIntValue("V5"));
  
  //Open/close door  
  int doorStatus=readIntValue("V6");
  if(doorStatus==0){
    closeDoor();
  }else if(doorStatus==1){
    openDoor();
  }else{
    digitalWrite(pinMotor1,LOW);
    digitalWrite(pinMotor2,LOW);    
  }
  
  //Turn on/off alarm
  int alarmStatus=readIntValue("V7");
  if(alarmStatus==0){
    tone(pinBuzzer,0);
  }
  Serial.println("-------------------------------------------");
}

int readLabaledValue(String label, String pin){
  Serial.println(String("Setting property on "+pin+" w/ value: "+label));
  String response;
  if (httpRequest(String("GET /") + auth + "/update/"+pin+"?value=" + label, "", response)) {
    if (response.length() != 0) {
      Serial.print("WARNING: ");
      Serial.println(response);
    }
  }
  return response.toInt();
}
int readIntValue(String pin){
  Serial.println(String("Reading value of "+pin));
  String response;
  if (httpRequest(String("GET /") + auth + "/get/"+pin, "", response)) {
    Serial.print("Value from server: ");
    Serial.println(response);
  }
  return response.toInt();
}
float readFloatValue(String pin){
  Serial.println(String("Reading value of "+pin));
  String response;
  if (httpRequest(String("GET /") + auth + "/update/"+pin, "", response)) {
    Serial.print("Value from server: ");
    Serial.println(response);
  }
  return response.toFloat();
}
void putValue(String value,String pin){
  Serial.print("Sending value: ");
  Serial.println(value);
  String response;
  String putData = String("[\"") + value + "\"]";
  if (httpRequest(String("PUT /") + auth + "/update/"+pin, putData, response)) {
    if (response.length() != 0) {
      Serial.print("WARNING: ");
      Serial.println(response);
    }
  }
}
bool httpRequest(const String& method, const String& request, String& response){
  //Serial.print(F("Connecting to "));
  //Serial.print(host);
  //Serial.print(":");
  //Serial.print(port);
  //Serial.print("... ");
  if (client.connect(host, port)) {
    Serial.println("OK");
  } else {
    //Serial.println("failed");
    return false;
  }

  client.print(method); client.println(F(" HTTP/1.1"));
  client.print(F("Host: ")); client.println(host);
  client.println(F("Connection: close"));
  if (request.length()) {
    client.println(F("Content-Type: application/json"));
    client.print(F("Content-Length: ")); client.println(request.length());
    client.println();
    client.print(request);
  } else {
    client.println();
  }

  //Serial.println("Waiting response");
  int timeout = millis() + 5000;
  while (client.available() == 0) {
    if (timeout - millis() < 0) {
      Serial.println(">>> Client Timeout !");
      client.stop();
      return false;
    }
  }

  //Serial.println("Reading response");
  int contentLength = -1;
  while (client.available()) {
    String line = client.readStringUntil('\n');
    line.trim();
    line.toLowerCase();
    if (line.startsWith("content-length:")) {
      contentLength = line.substring(line.lastIndexOf(':') + 1).toInt();
    } else if (line.length() == 0) {
      break;
    }
  }

  //Serial.println("Reading response body");
  response = "";
  response.reserve(contentLength + 1);
  while (response.length() < contentLength && client.connected()) {
    while (client.available()) {
      char c = client.read();
      if(c=='['||c==']'||c=='"'){
        Serial.print("");
      }else{        
        response += c; 
      }
    }
  }
  client.stop();
  return true;
}
void connectNetwork(){
  Serial.print("Connecting to ");
  Serial.println(WIFI_SSID);
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println();
  Serial.println("WiFi connected");
}
void closeDoor(){
  digitalWrite(pinMotor1,LOW);
  digitalWrite(pinMotor2,HIGH);
  delay(10000);
  digitalWrite(pinMotor1,LOW);
  digitalWrite(pinMotor2,LOW);
  putValue("2","V6");
}
void openDoor(){
  digitalWrite(pinMotor1,HIGH);
  digitalWrite(pinMotor2,LOW);
  delay(10000);
  digitalWrite(pinMotor1,LOW);
  digitalWrite(pinMotor2,LOW);
  putValue("2","V6");
}

void soundAlarm(){
  while(readIntValue("V7")!=0){
    tone(pinBuzzer,1000);
    delay(100);
    tone(pinBuzzer,0);
    delay(100);    
  }
  putValue("1","A7");
}
void controlRoom(int room, int stat){
  if(stat==HIGH){
    digitalWrite(room,stat);
    Serial.print("Cuarto ");Serial.print(room);Serial.println(": Encendido");
  }else{
    digitalWrite(room,stat);
    Serial.print("Cuarto ");Serial.print(room);Serial.println(": Apagado");
  }
}
float getLM35data(){
  int datoADC; //datos obtenido del ADC 10 bits
  float grads=0.0;
  datoADC=analogRead(A0);
  grads=((datoADC)*9.0/5.0)+32.0;
  Serial.print("Temperatura en C: ");Serial.println(grads);
  delay(1000);
  return grads;
}
int getPIRdata(){
  int value= digitalRead(pinPIR); 
  Serial.print("Sensor PIR: ");Serial.println(value);
  if (value == 1){
    digitalWrite(pinR, HIGH);
    delay(500);
    digitalWrite(pinR, LOW);
    delay(500);
    putValue(String(1),"V7");
    soundAlarm();
  }else{
    digitalWrite(pinR, LOW);
  }
  return value;
}

