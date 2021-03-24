// Agent participant in project contractNetProtocol

/* Initial beliefs and rules*/
+service(X).
+price(P).
+accepted(C) <- !proposalAccepted(C).

newPrice(SP,OFFSET):- price(CP) & SP = CP + (OFFSET*CP).

/* Plans */
+!bid(RequestedService)[source(InitiatiorName)] <- 
	?service(MyService);
	.my_name(Me);
	.println(Me, " received a bid for ", RequestedService, " from ", InitiatiorName);
	if(MyService == RequestedService){
		.random(X);
		?newPrice(SellingPrice,X);
		.println("My offer to ", InitiatiorName, " is ", SellingPrice);
		.send(InitiatiorName,tell,proposal(MyService,SellingPrice));
	}
.

+!proposalAccepted(Client) <- 
	.println("We have a DEAL with: ", Client);
.