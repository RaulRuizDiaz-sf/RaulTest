Id createdByUserId = '005G000000739rEIAQ';
String env = 'UAT';
datetime cratedDateValue = (datetime) date.newInstance(2023,5,25);
date activationDateValue = date.newInstance(2040,12,31);
String fakeEmail = 'Oreilly_'+ env +'_'+ System.now().format('yyyyMMdd') + '@yopmail.com';

list<User> lstUsr=new List<User>();

Database.DMLOptions dlo = new Database.DMLOptions();

dlo.EmailHeader.triggerAutoResponseEmail = false;
dlo.EmailHeader.triggerOtherEmail = false;
dlo.EmailHeader.triggerUserEmail = false;

system.debug('Select id,Email,UserName,IsActive, CreatedDate, CreatedById, Activation_Date__c '+
              'from user '+
              'where CreatedById = \''+createdByUserId+ '\' '+
              'and CreatedDate >= ' + cratedDateValue.format('yyyy-MM-dd') + 'T00:00:00.000+0000 '+
              'and CreatedDate <=' + cratedDateValue.addDays(2).format('yyyy-MM-dd') + 'T00:00:00.000+0000 ' +
              'and IsActive = false '+
              'and Activation_Date__c =' + String.valueof(activationDateValue) );

for(User usr:[Select id,Email,UserName,IsActive, CreatedDate, CreatedById, Activation_Date__c
              from user
              where CreatedById =: createdByUserId
              and CreatedDate <: cratedDateValue
              and CreatedDate >: cratedDateValue.addDays(2)
              and IsActive = false
              and Activation_Date__c =: activationDateValue]){
	usr.Email = UserName;
    lstUsr.add(usr);
}

//Database.Update (lstUsr,dlo);