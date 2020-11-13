#define _WINSOCK_DEPRECATED_NO_WARNINGS
#include<stdio.h>
#include<WinSock2.h>
#pragma comment(lib,"ws2_32.lib")
#define CONNECT_NUM_MAX 10


int main()
{
	WSADATA wsaData;
	int iRet = 0;
	iRet = WSAStartup(MAKEWORD(2, 2), &wsaData);
	if (iRet != 0)
	{
		printf("start up failed");
		return -1;
	}
	if (2 != LOBYTE(wsaData.wVersion) || 2 != HIBYTE(wsaData.wVersion))
	{
		WSACleanup();
		printf("version not correct");
		return -1;
	}
	SOCKET serverSocket = socket(AF_INET, SOCK_STREAM, 0);
	if (serverSocket == INVALID_SOCKET) 
	{
		printf("socket failed");
		return -1;
	}
	SOCKADDR_IN addrSrv;
	addrSrv.sin_addr.S_un.S_addr = htonl(INADDR_ANY);
	addrSrv.sin_family = AF_INET;
	addrSrv.sin_port = htons(6000);
	
	iRet = bind(serverSocket, (SOCKADDR*)&addrSrv, sizeof(SOCKADDR));
	if (iRet == SOCKET_ERROR) 
	{
		printf("bind error");
		return -1;
	}
	iRet = listen(serverSocket, CONNECT_NUM_MAX);
	if (iRet == SOCKET_ERROR) 
	{
		printf("listen error");
		return -1;
	}
	SOCKADDR_IN clientAddr;
	int len = sizeof(SOCKADDR);
	while (1)
	{
		SOCKET connSocket = accept(serverSocket, (SOCKADDR*)&clientAddr, &len);
		if (connSocket == INVALID_SOCKET) 
		{
			printf("accept error");
			return -1;
		}
		char sendBuf[100];
		sprintf_s(sendBuf, "Welcome %s",inet_ntoa(clientAddr.sin_addr));
		send(connSocket, sendBuf, strlen(sendBuf) + 1, 0);

		char recvBuf[100];
		recv(connSocket, recvBuf, 100, 0);
		printf("%s\n", recvBuf);
		closesocket(connSocket);
	}
	system("pause");
	return 0;
}