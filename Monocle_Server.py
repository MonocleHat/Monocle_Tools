import socket
import threading
import os
import subprocess

bind_ip = "0.0.0.0"
bind_port = 9999
flag = 0
server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server.bind((bind_ip,bind_port))
server.listen(5)

print ("[*] Mon_SERV is LIVE. Listening on %s:%d" % (bind_ip, bind_port))

def handle_client(client_socket):
    flag = 0
    startup = "Welcome to MonocleServer 1.0\nTo quit just send command \'QUIT\'\n"
    client_socket.send(startup.encode('utf-8'))
    while flag == 0:
        start = "[*] Enter Keyword: "
        client_socket.send(start.encode('utf-8'))
        request = client_socket.recv(1024)
        request = request.decode('utf-8')
        request = request.rstrip()
        if request == "HELP":
            response = "[+] DISPLAYING COMMANDS\n-------------------\n"
            response += "HELP - Show this list\n"
            response += "SHELL - Execute Shell commands on this server\n"
            response += "TIME - Display server time\n"
            response += "PING - Check server response\n"
            response += "INFO - Server Info\n"
            response += "QUIT - Prompts for confirmation before quitting session\n"
            response += "[+] Make your selection\n-------------------\n"
            client_socket.send(response.encode('utf-8'))
        elif request == "TIME":
            result = subprocess.check_output('date',shell=True)
            result = result.decode('utf-8').rstrip()
            response = "[*] "
            response += result
            response += "\n"
            client_socket.send(response.encode('utf-8'))
        elif request == "PING":
            response = "[*] "
            response += "PONG!\n"
            client_socket.send(response.encode('utf-8'))
        elif request == "INFO":
            response = "[*] "
            response += "Server Information"
            response += "\nBasic Python TCP Server created to experiment with sockets\n"
            response += "Created by MonocleHat\n"
            client_socket.send(response.encode('utf-8'))
        elif request == "SHELL":
            shellflag = 0
            response = "[*] Send shell commands; recieve responses."
            response += "send \'q\' to end session\n"
            client_socket.send(response.encode('utf-8'))
            while shellflag == 0:
                response = "[+] Enter Command: "
                client_socket.send(response.encode('utf-8'))
                command = client_socket.recv(1024)
                command = command.rstrip()
                command = command.decode('utf-8')
                if command == "q":
                    print (command)
                    shellflag = 0
                    break
                else:
                    response = subprocess.check_output(command, shell=True)
                    response = response.decode('utf-8').rstrip()
                    client_socket.send(response.encode('utf-8'))
                
            response = "Shell session quit\n"
            client_socket.send(response.encode('utf-8'))
            
        
        elif request == "QUIT":
            response = "Session ending"
            client_socket.send(response.encode('utf-8'))
            flag = 1
            client_socket.close()
            print ("[*] Connection closed from: %s:%d" % (addr[0],addr[1]))
        else:
            print("error")
while True:
    client,addr = server.accept()
    print ("[*] Connection accepted from: %s:%d" % (addr[0],addr[1]))
    client_handler = threading.Thread(target = handle_client,args=(client,))
    client_handler.start()
