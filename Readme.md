# **Build a contact center for booking and checking appointment with AWS Connect/Lex/Lambda**

## **Overview**
In this lab we, you will be building a contact center using Amazon Connect and integrating with Amazon Lex. Amazon Lex interprets dual-tone multi-frequency signaling (DTMF) digits entered on a keypad. It matches the intent based on that input in the same way it matches the intent when you speak an utterance. This provides for greater flexibility for customers to interact with your contact center. 

## **Architecture**
![sparkles](images/Architecture-Diagram.png)

## **Walkthrough**
1. [Create Lex Chat Bot](#CreateLexChatBot)
2. [Create Amazon Connect Instance](#CreateAmazonConnect#)
3. [Amazon Connect Lex Integration](#integration)




### **Create Lex Chat Bot <a name="CreateLexChatBot"></a>**

1.	Open the Amazon Lex Console in N.Virginia Region at https://console.aws.amazon.com/lex/home?region=us-east-1#
2.	On the Bots page, choose **Create**
![sparkles](/images/Bot_Create.png)
3.	Create a **‘Custom bot’**.
Name the Bot as **BookAppointment**
Complete other fields as specificed in the picture below and choose **Create**.
![sparkles](images/Lex-CustomBot.png)

#### **Create BookAppointment Intent** - Action user wants to perform
1.	Choose **Create Intent**. Name the intent as **BookAppointment**
![sparkles](images/Intent_BookAppointment_Create.png)
![sparkles](/images/Intent_BookAppointment_Name.png)

2.	Create Utterances - Spoken or typed phrases that will invoke our intent as shown in the picture
![sparkles](images/Intent_BookAppointment_Utterances.png)

3.	Set initialization and validation function
![sparkles](/images/Intent_BookAppointment_Lambda.png)

1. Adding Slots - Parameters required to fulfil the intent.
Configure the slots as follows:
![sparkles](images/Intent_BookAppointment_Slots.png)

5. Set Fulfillment function

![sparkles](images/Intent_BookAppointment_Fulfillment.png)


#### **Create CheckAppointment Intent**
1.	Choose to **Add Intents**. Name intent as CheckAppointment
![sparkles](images/Intent_CheckAppointment_Create.png)

1. Create Utterances - Spoken or typed phrases that will invoke our intent
![sparkles](images/Intent_CheckAppointment_Utterances.png)

3.	Set Fulfillment function

![sparkles](images/Intent_BookAppointment_Fulfillment.png)


#### Build and Publish Lex Bot ####
Build and Publish the Bot. Choose Alias as BookAppointment.
![sparkles](images/Bot_Build.png)
![sparkles](images/Bot_Publish.png)

### Create Amazon Connect Instance <a name="CreateAmazonConnect"></a>
For the simplicity of this lab, we created a Connect instance in **Sydney Region** for you. You can find the Connect instance at https://ap-southeast-2.console.aws.amazon.com/connect/home?region=ap-southeast-2
![sparkles](images/connect-instace.png)

Click on the **Instance Alias**

### Integrate Amazon Connect and Lex <a name="integration"></a>
#### Add the Amazon Lex bot to Amazon Connect Instance
![sparkles](images/connect-lex-add-lex.png)

#### Create a contact flow and add your Amazon Lex bot
1.	Log in to your Amazon Connect instance
![sparkles](images/connect-lex-login.png)


2. Choose **Routing -> Contact flows -> Create contact flow**, and type a **SydneySummitContactFlow**
![sparkles](images/connect-lex-contactflox.png)
![sparkles](images/connect-contact-flow-name.png)

3.	Under **Interact**, drag a **Get customer input** block onto the designer.
4.	Open the **Get customer input** block, and choose **Text to speech (Ad hoc)**, Enter text.
5.	Type a message that provides callers with information about what they can do. For example, use a message that matches the intents used in the bot, such as **“To make an appointment, press or say 1. To check an appointment, press or say 2”**

![sparkles](images/connect-contactflow-getcustomerinput-1.png)


6.	Select Amazon Lex, for name, use **BookAppointment**. For alias, use **BookAppointment**
![sparkles](images/connect-contactflow-addlexbot.png)
7.	Choose **Add an attribute -> Use attribute**. For type, choose **System**. For Attribute, choose **Customer Number**. For Destination Key, set it as **ContactNumber**. 
![sparkles](images/connect-contactflow-addattributes.png)

8.	To specify the intents, choose **Add an intent**. Add **BookAppointment** and **CheckAppointment**.
![sparkles](images/connect-contactflow-addintents.png)

9. Connect **Get customer input** block to the Entry point block.
![sparkles](images/connect-contactflow-getcustomerinput-2.png)

10.	Under **Interact**, drag a Play prompt block onto the designer, and connect it to the **Default** and **Error** from the **Get customer input** block. 
![sparkles](images/connect-contactflow-playprompt-1.png)

11.	Open the Play prompt block and Text to speech (Ad hoc), Enter text. Type “All of our agents are busy at the moment. Please call again”. Save the block.

![sparkles](images/connect-contactflow-playprompt-2.png)

12.	Under **Terminate/Transfer**, drag **Disconnect / hang up**, connect it to the **Play Prompt block** and the **BookAppointment** and **CheckAppointment** intents. 

![sparkles](images/connect-contactflow-disconnect.png)

13.	Save and publish the contact flow.

#### Assign the contact flow to a phone number
1.	Open the Amazon Connect Dashboard

2.	Choose View phone numbers.
![sparkles](images/connect-phonenumber-1.png)

3.	**Claim a number**, select Toll free. Choose country as Australia and any number available

![sparkles](images/connect-phonenumber-2.png)

4.	In the **Contact flow/IVR** menu, choose the **SydneySummitContatFlow** flow that you just created.
![sparkles](images/connect-contactflow.png)

5.	Choose **Save.**

### Try it
Dial the number you claimed above, and follow the prompts.
