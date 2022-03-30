// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents

// use without flag or marker
AggregateResult[] agregatedresult = [SELECT StageName, MIN(Amount), MAX(Amount), AVG(Amount) FROM Opportunity GROUP BY StageName];

for ( AggregateResult result : agregatedresult) {
    System.debug('Stage Name '+ result.get('StageName') + ' Min Amount ' + result.get('expr0') + ' Max Amount ' + result.get('expr1') + ' AVG ' + result.get('expr2'));
}

// use with flags or marker
AggregateResult[] agregatedresult = [SELECT StageName, MIN(Amount) MinAmount, MAX(Amount) MaxAmount, AVG(Amount) AVG FROM Opportunity GROUP BY StageName];

for ( AggregateResult result : agregatedresult) {
    System.debug('Stage Name '+ result.get('StageName') + ' Min Amount ' + result.get('MinAmount') + ' Max Amount ' + result.get('MaxAmount') + ' AVG ' + result.get('AVG'));
}

// pool SOQL
for ( AggregateResult result : [SELECT StageName, MIN(Amount) MinAmount, MAX(Amount) MaxAmount, AVG(Amount) AVG FROM Opportunity GROUP BY StageName]) {
    System.debug('Stage Name '+ result.get('StageName') + ' Min Amount ' + result.get('MinAmount') + ' Max Amount ' + result.get('MaxAmount') + ' AVG ' + result.get('AVG'));
}

