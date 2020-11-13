#define _WINSOCK_DEPRECATED_NO_WARNINGS
#include<stdio.h>
#include<WinSock2.h>

#pragma comment(lib,"ws2_32.lib")
int main() 
{
	WSADATA wsaData;
	int iRet = 0;
	iRet = WSAStartup(MAKEWORD(2, 2), &wsaData);
	if (iRet != 0)
	{
		printf("startup error");
		return -1;
	}
	if (2 != LOBYTE(wsaData.wVersion) || 2 != HIBYTE(wsaData.wVersion)) 
	{
		WSACleanup();
		printf("version error");
		return -1;
	}
	SOCKET clientSocket = socket(AF_INET, SOCK_STREAM, 0);
	if (clientSocket == INVALID_SOCKET) 
	{
		printf("socket error");
		return -1;
	}

	SOCKADDR_IN srvAddr;
	srvAddr.sin_addr.S_un.S_addr = inet_addr("127.0.0.1");
	srvAddr.sin_family = AF_INET;
	srvAddr.sin_port = htons(6000);
	iRet = connect(clientSocket, (SOCKADDR*)&srvAddr, sizeof(SOCKADDR));
	if (0 != iRet) 
	{
		printf("connect error");
		return -1;
	}
	char recvBuf[100];
	recv(clientSocket, recvBuf, 100, 0);
	printf("%s\n", recvBuf);

	char sendBuf[100];
	sprintf_s(sendBuf,100,"Hello,this is client %s","อรืำ");
	send(clientSocket, sendBuf, strlen(sendBuf) + 1, 0);
	closesocket(clientSocket);
	WSACleanup();
	system("pause");
	return 0;
}