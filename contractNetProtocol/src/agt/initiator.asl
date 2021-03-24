// Agent sample_agent in project contractNetProtocol

/* Initial beliefs and rules */
+request(R).

+proposal(Service,Price)[source(Ag)] <-
	.print("I received a proposal for: ", Service ," with Price: ",  Price, " from ", Ag);
.

accept(InputList,Output):-
	.min(InputList,Output)
.

/* Plans */
+!cfp:true<-
	?request(R);
	for(.member(S,R)){
		.broadcast(achieve,bid(S));
	}
	.wait(2000);
	for(.member(S,R)){
		!chooseProposal(S);
	}
.

+!chooseProposal(Service):true<-	
	.findall(Y,proposal(Service,Y),ListValues);
	if(ListValues \== []){
		?accept(ListValues,Accepted);
		.findall(Z,proposal(Service,Accepted)[source(Z)],ListSender);
		.nth(0,ListSender,Sender);
		.my_name(Me);
		.println("I (", Me, ") will ACCEPT the ", Service, " Service, offered for ", Accepted, " proposed by ", Sender);
		!finishDeal(Me,Sender)
	}
.

+!finishDeal(Me,Sender) <-
 .send(Sender,tell,accepted(Me))
.