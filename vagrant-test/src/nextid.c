#include<stdio.h>
#include<string.h>
#include<sys/socket.h>
#include<arpa/inet.h>
#include<unistd.h>
#include<memory.h>

int main(int argc , char *argv[])
{
    if(argv[1]==NULL){
        // In case of empty commant option
        printf("Invalid command option. Try \"nextid gen\" \n");
        return 1;
    }
    int sock;
    int c;
    struct sockaddr_in server;
    char *message , server_reply[1000];
     
    //Create socket
    sock = socket(AF_INET , SOCK_STREAM , 0);
    if (sock == -1)
    {
        printf("Could not create socket\n");
    }
     //Prepare the sockaddr_in structure
    server.sin_addr.s_addr = inet_addr("127.0.0.1");
    server.sin_family = AF_INET;
    server.sin_port = htons( 8080 );
 
    //Connect to remote server
    if (connect(sock , (struct sockaddr *)&server , sizeof(server)) < 0)
    {
        perror("Connection failed. Error\n");
        return 1;
    }


         
        if( send(sock , argv[1] , strlen(argv[1]) , 0) < 0)
        {
            puts("Sending failed");
            return 1;
        }
         
        if( (c=recv(sock , server_reply , 1000 , 0)) > 0)
        {
            server_reply[c]='\0';
            if(c<10){
                printf("Your generated id: %s\n",  server_reply);
            }
            else{
                printf("%s\n",  server_reply);
            }

            fflush(stdout); 
        }
        else
        {
            puts("Server is not answering.....");
            return 1;
        }
     
    close(sock);
    return 0;
}