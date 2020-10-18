# TCP vs. UDP
## UDP
- Best effort delivery
- Can be out of order
- Can lose packets
- Message boundaries are preserved
- Recipient need to know the address of the sender to reply

## TCP
- Guaranteed delivery
- Recipient does not need to know the sender's address to reply
- Message boundaires are not guaranteed
- Four entities defining a connection
	- client port (ephemeral)
	- client address
	- server port (well known)
	- server address
