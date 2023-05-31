Id createdByUserId = '005G000000739rEIAQ'; //Validate
String env = 'UAT'; //Update
date activationDateValue = date.newInstance(2040,12,31); //Validate
String fakeEmail = 'OR_'+ env +'_'+ System.now().format('yyyyMMdd') + '@yopmail.com';

list<User> lstUsr=new List<User>();

Database.DMLOptions dlo = new Database.DMLOptions();

dlo.EmailHeader.triggerAutoResponseEmail = false;
dlo.EmailHeader.triggerOtherEmail = false;
dlo.EmailHeader.triggerUserEmail = false;

//Update last_N_Days
for(User usr:[Select id,Email,UserName,IsActive, CreatedDate, CreatedById, Activation_Date__c
              from user
              where CreatedById =: createdByUserId
              and CreatedDate = LAST_N_DAYS:6        
              and Activation_Date__c =: activationDateValue]){
    usr.Email = usr.UserName;
    lstUsr.add(usr);
}