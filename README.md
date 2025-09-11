# SeeU
With my colleague, I have participated in a campain which scored us Project Management Principles certificate, by creating an application which allows to contact other application users just by their localisation

I have created this project as a part of an initiative called Zwolnieni z Teorii (eng. Exempt from Theory). The campaign, in the form of a long-term objective, offered earning a Project Management Principles certificate, which we received.
To finalize the project, we had to create an application for more than 200 users. In our case, I though of an application which would allow user to see to the neares users and send him a message. For further details of our struggles and evaluation, please visit docs.
To create an application, my friend was responsible for the frontend, while I was responsible for the whole backend. 
To create the backend, as a primary technology, I have used Node.js with which I have created a client-server architecture with based on REST protocol. All data about aplication's status and the data regarding localisation and sending messages were stored in a database based on mySQL. Then to comunicate between frontend and backend we used web server responses - receiving data using demands like GET, POST, PUT. As the data was transferred through Interned, I encrypted the communication by using hash functions through JWT tokes. 
