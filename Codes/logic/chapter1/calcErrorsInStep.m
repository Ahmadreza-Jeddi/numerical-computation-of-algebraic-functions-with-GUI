function [steps, relError, AbsError, val] = calcErrorsInStep(f, vars, varsValues,absuluteIn, parametricVars, ischop, FPD)
warning off;
digits(FPD);
ischop = 0;
myVarsSymbol = @(i) ['a',num2str(i),'a'];
myVarsCounter=1;
stepCounter = 1;
steps = cell(0,1);
relError = cell(0, 1);
AbsError = cell(0, 1);
val = cell(0, 1);
% myVarsArrPars = zeros(100, 5);
myVarsArrPars = cell(0, 5);
[startIndex,endIndex] = level1parenthesis(f);
innerStepsCount = startIndex;
innerSteps = cell(0, 1);
inneRrelErrors = cell(0, 1);
inneAbsErrors = cell(0, 1);
innerVals = cell(0, 1);
tempf = f;
if(size(startIndex, 1)>0)
for i = size(startIndex, 1):-1:1
    newf = tempf(startIndex(i): endIndex(i));
    tempf=[tempf(1:startIndex(i) - 1), myVarsSymbol(myVarsCounter), tempf(endIndex(i)+1:size(tempf, 2))];
    newf = newf(2:size(newf, 2)-1);
    [tmpinnerSteps, tmpinneRrelErrors, tmpinneAbsErrors, tmpinnerVals] = calcErrorsInStep(newf, vars, varsValues,absuluteIn, parametricVars, 0, FPD);
    innerSteps = [tmpinnerSteps;innerSteps];
    inneRrelErrors = [tmpinneRrelErrors;inneRrelErrors];
    inneAbsErrors =[tmpinneAbsErrors;inneAbsErrors];
    innerVals =[tmpinnerVals;innerVals];
    myVarsArrPars = [myVarsArrPars;startIndex(i) ,endIndex(i),tmpinneRrelErrors( size(tmpinneRrelErrors, 1),1),tmpinneAbsErrors( size(tmpinneAbsErrors, 1),1),tmpinnerVals( size(tmpinnerVals, 1),1)];
    myVarsCounter = myVarsCounter+1;

end
end
% TODO nasted power and only number and not parameter
mySteps = cell(0, 1);
myrelError = cell(0, 1);
myAbsError = cell(0, 1);
myval = cell(0, 1);

% power
while(size(regexp(tempf,'(\w+\.?\w*)(\^)(\w+\.?\w*)', 'tokens'))~= 0)
    tmp = regexp(tempf,'(\w+\.?\w*)(\^)(\w+\.?\w*)', 'tokens');
    [start, endd] = regexp(tempf,'(\w+\.?\w*)(\^)(\w+\.?\w*)');
    tmp=tmp{1};
    tmpfirst = tmp{1};
    op = tmp{2};
    tmpsec = tmp{3};
    
    if(size(str2num(tmpfirst))== 0)
        [tmpval1, tmpRelError1, tmpAbsError1] = findVarPar(tmpfirst, myVarsCounter, myVarsArrPars, vars, varsValues, absuluteIn, ischop, FPD);
    else
        tmpval1 = str2num(tmpfirst);
        tmpRelError1 = 0;
        tmpAbsError1 = 0;
    end
    
    if(size(str2num(tmpsec))== 0)
        [tmpval2, tmpRelError2, tmpAbsError2] = findVarPar(tmpsec, myVarsCounter, myVarsArrPars, vars, varsValues, absuluteIn, ischop, FPD);
    else
        tmpval2 = str2num(tmpsec);
        tmpRelError2 = 0;
        tmpAbsError2 = 0;
    end
   
    [tempRelError, tempAbsError, tempAns] = calcExp(tmpRelError1, tmpAbsError1, tmpval1, tmpRelError2, tmpAbsError2, tmpval2, ischop, FPD);
    tempf = [tempf(1:start(1)-1), myVarsSymbol(myVarsCounter), tempf(endd(1)+1:size(tempf, 2))];
    myVarsArrPars = [myVarsArrPars;start(1),endd(1),tempRelError,tempAbsError,tempAns];
    myVarsCounter = myVarsCounter+1;
    
    if(isa(tmpval1, 'sym'))
        tmpval1 = char(tmpval1);
    else
        tmpval1 = num2str(double(tmpval1));
    end
    if(isa(tmpval2, 'sym'))
        tmpval2 = char(tmpval2);
    else
        tmpval2 = num2str(double(tmpval2));
    end
    
    tmp = [tmpval1, '^', tmpval2];
    
    mySteps = [mySteps; tmp]; 
	myrelError = [myrelError;vpa(tempRelError)];
    myAbsError = [myAbsError;vpa(tempAbsError)];
    myval = [myval;vpa(tempAns)];
end


% * \
while(size(regexp(tempf,'(\w+\.?\w*)(\*|/)(\w+\.?\w*)', 'tokens'))~= 0)
    tmp = regexp(tempf,'(\w+\.?\w*)(\*|/)(\w+\.?\w*)', 'tokens');
    [start, endd] = regexp(tempf,'(\w+\.?\w*)(\*|/)(\w+\.?\w*)');
    tmp=tmp{1};
    tmpfirst = tmp{1};
    op = tmp{2};
    tmpsec = tmp{3};
    
    if(size(str2num(tmpfirst))== 0)
        [tmpval1, tmpRelError1, tmpAbsError1] = findVarPar(tmpfirst, myVarsCounter, myVarsArrPars, vars, varsValues, absuluteIn, ischop, FPD);
    else
        tmpval1 = str2num(tmpfirst);
        tmpRelError1 = 0;
        tmpAbsError1 = 0;
    end
    
    if(size(str2num(tmpsec))== 0)
        [tmpval2, tmpRelError2, tmpAbsError2] = findVarPar(tmpsec, myVarsCounter, myVarsArrPars, vars, varsValues, absuluteIn, ischop, FPD);
    else
        tmpval2 = str2num(tmpsec);
        tmpRelError2 = 0;
        tmpAbsError2 = 0;
    end
    if(op == '*')
        [tempRelError, tempAbsError, tempAns] = calcMul(tmpRelError1, tmpAbsError1, tmpval1, tmpRelError2, tmpAbsError2, tmpval2, ischop, FPD);
    else
        [tempRelError, tempAbsError, tempAns] = calcDiv(tmpRelError1, tmpAbsError1, tmpval1, tmpRelError2, tmpAbsError2, tmpval2, ischop, FPD);
    end
    tempf = [tempf(1:start(1)-1), myVarsSymbol(myVarsCounter), tempf(endd(1)+1:size(tempf, 2))];
    myVarsArrPars = [myVarsArrPars;start(1),endd(1),tempRelError,tempAbsError,tempAns];
    myVarsCounter = myVarsCounter+1;
    
    if(isa(tmpval1, 'sym'))
        tmpval1 = char(tmpval1);
    else
        tmpval1 = num2str(double(tmpval1));
    end
    if(isa(tmpval2, 'sym'))
        tmpval2 = char(tmpval2);
    else
        tmpval2 = num2str(double(tmpval2));
    end
    
    if(op == '*')
        tmp = [tmpval1, '*', tmpval2];
    else
        tmp = [tmpval1, '/', tmpval2];
    end
    mySteps = [mySteps; tmp]; 
	myrelError = [myrelError;vpa(tempRelError)];
    myAbsError = [myAbsError;vpa(tempAbsError)];
    myval = [myval;vpa(tempAns)];
end

% + -

while(size(regexp(tempf,'(\w+\.?\w*)(\+|-)(\w+\.?\w*)', 'tokens'))~= 0)
    tmp = regexp(tempf,'(\w+\.?\w*)(\+|-)(\w+\.?\w*)', 'tokens');
    [start, endd] = regexp(tempf,'(\w+\.?\w*)(\+|-)(\w+\.?\w*)');
    tmp=tmp{1};
    tmpfirst = tmp{1};
    op = tmp{2};
    tmpsec = tmp{3};
    if(size(str2num(tmpfirst))== 0)
        [tmpval1, tmpRelError1, tmpAbsError1] = findVarPar(tmpfirst, myVarsCounter, myVarsArrPars, vars, varsValues, absuluteIn, ischop, FPD);
    else
        tmpval1 = str2num(tmpfirst);
        tmpRelError1 = 0;
        tmpAbsError1 = 0;
    end
    
    if(size(str2num(tmpsec))== 0)
%         TODO
        [tmpval2, tmpRelError2, tmpAbsError2] = findVarPar(tmpsec, myVarsCounter, myVarsArrPars, vars, varsValues, absuluteIn, ischop, FPD);
    else
        tmpval2 = str2num(tmpsec);
        tmpRelError2 = 0;
        tmpAbsError2 = 0;
    end
    if(op == '+')
%         TODO
        [tempRelError, tempAbsError, tempAns] = calcSum(tmpRelError1, tmpAbsError1, tmpval1, tmpRelError2, tmpAbsError2, tmpval2, ischop, FPD);
    else
        [tempRelError, tempAbsError, tempAns] = calcSub(tmpRelError1, tmpAbsError1, tmpval1, tmpRelError2, tmpAbsError2, tmpval2, ischop, FPD);
    end
    tempf = [tempf(1:start(1)-1), myVarsSymbol(myVarsCounter), tempf(endd(1)+1:size(tempf, 2))];
    myVarsArrPars = [myVarsArrPars;start(1),endd(1),tempRelError,tempAbsError,tempAns];
    myVarsCounter = myVarsCounter+1;
    
%     TODO
    if(isa(tmpval1, 'sym'))
        tmpval1 = char(vpa(tmpval1));
    else
%         TODO convert to char
        tmpval1 = char(vpa(tmpval1));
    end
    if(isa(tmpval2, 'sym'))
        tmpval2 = char(vpa(tmpval2));
    else
        tmpval2 = char(vpa(tmpval2));
    end
    
    if(op == '+')
          tmp = [tmpval1, '+', tmpval2];
    else
        tmp = [tmpval1, '-', tmpval2];
    end
%     todo
    mySteps = [mySteps; tmp]; 
	myrelError = [myrelError;vpa(tempRelError)];
    myAbsError = [myAbsError;vpa(tempAbsError)];
    myval = [myval;vpa(tempAns)];
end


steps = [steps;innerSteps];
relError = [relError;inneRrelErrors];
AbsError = [AbsError;inneAbsErrors];
val = [val;innerVals];
steps = [steps;mySteps];
relError = [relError;myrelError];
AbsError = [AbsError;myAbsError];
val = [val;myval];
end

