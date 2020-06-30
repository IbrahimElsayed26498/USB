// In the name of Allah, the Gracious, the Merciful
unsigned char readbuff[64] absolute 0x500;
unsigned char writebuff[64] absolute 0x540;

char count;
char check[4];
unsigned char counter = 0;
unsigned char i;
void interrupt(){
     USB_Interrupt_Proc();
}

void main() {
     trisb = 0;
     portb = 0;
     ADCON1 = 0x0f;
     CMCON = 7;
     
     HID_Enable(&readbuff, &writebuff);
     
     while(1){
          counter = 0;
          while(!HID_Read());
          for(i = 0; i < 4; i++){
                  check[i] = readbuff[i];
          }
          while(counter < 4){
                  check[counter] = (char)toupper(check[counter]);
                  counter++;
          }
          if(check[0] == 'U' && check[1] == 'P')
              portb++;
           else if (check[0] == 'D' && check[1] == 'O' && check[2] == 'W' && check[3] == 'N')
              portb--;
           else;
           
               
     }
     
}