
However, it is not recommended to support data transmission/reception of 3, 4, and more people through a P2P connection because the client side is heavily overloaded. 

## Signaling Server(P2P/Mesh)

### Features

  - It relays only the session information signal of offer and answer between peers. Therefore, the load on the server occurs only when WebRTC relays information between peers for the first time.
  - After the connection between peers is completed, there is no additional load on the server.
  - It is suitable for 1:1 connection.

### Advantages

- Because the server load is low, the server resources are low.
- Real-time is guaranteed because data is transmitted and received through direct connection between peers.

### Disadvantages

- In 1:N or N:M connections, the overload of the client increases rapidly. For example, assuming that 5 people connect to WebRTC as shown in the picture above, there are 4 Uplink (the number of sending my data to other connected users) and 4 Downlink (the number of connecting other users’ data coming to me). It maintains 8 links and transmits and receives data. (In the figure, data exchange is expressed as a link.)

## SFU(Selective Forwarding Unit) Server

### Features

- It is a central server method that relays end-to-end media traffic.
- It connects the peer between the server and the client, not between the client peers.
- In all connection types such as 1:1, 1:N, N:N or N:M, the client only needs to send its own video data to the server without having to send data to all connected users (that is, 1 Uplink).
- However, if it is a 1:N, N:N or N:M format, you need to maintain peers that receive data as many as the number of peers. (Downlink is the same as in the case of P2P/Mesh (Signaling Server), if 5 servers, download link would be 5)
- It is suitable for real-time streaming in 1:N format or small N:M format.

### Advantages

- Although data passes through a server and is slower than when using a signaling server (P2P/Mesh), it can maintain a similar level of real-time.
- The load on the client is reduced compared to using a signaling server.

### Disadvantages

- Server cost increases compared to signaling server.
- In a large-scale N:M structure, the client still handles a lot of load.



## MCU(Multi-point Control Unit) Server

### Features

- It is a central server method in which multiple transmission media are mixed (muxed) or processed (transcoding) in a central server and delivered to the receiving side. *For example, if 5 people connect to WebRTC, the video data of 4 people except one of them is edited into one video data, and the audio data is also edited and sent to one person. The same applies to the remaining 4 people.*
- It connects the peer between the server and the client, not between the client peers.
- In all connection types, the client only needs to send its own video data to the server without having to send data to all connected users (ie, there is 1 Uplink).
- In all connection types, the client only needs to receive data from the server to one peer regardless of the number of connected users (i.e., 1 downlink).
- High computing power of the central server is required.

### Advantages

- The load on the client is significantly reduced (1 uplink and 1 downlink, total 2)
- It can be used for N:M architecture (I’m not sure if it can be said to be suitable… more suitable than other servers).

### Disadvantages

- Real-time, the biggest advantage of WebRTC, is hampered.
- Server cost is high in the process of combining video and audio.
