NumberOfPopulation=20;
Probability.matting=0.8;
Probability.mutation=0.01;
NumberOfItterations=20;
decimalPoints=10;
MutationPercentage=0.1;
LoadBalancing=0;

geneticsUsers=inUsersMore;
PopulationArray=[];
Number_Of_genes=0;

for k=1:NumberOfPopulation
    NewUsersArray=[];
    for j=1:length(Users)
        user=Users(j);
        if length(user.AllPossibleCells(1,:))>=2
            x.binary=[];
            x.cell=[];
            x.numarical=[];
            x.FittnessVall=0;
            for i=1:length(user.AllPossibleCells(1,:))
                x.numarical(end+1)=rand(1);
                x.cell(:,end+1)=user.AllPossibleCells(:,i);
            end
            x.binary=zeros(1,length(x.numarical));
            [maxval,index]=max(x.numarical);
            x.binary(index)=1;
            x.cell(7,:)=(x.cell(5,:)-mean(x.cell(5,:)))/std(x.cell(5,:)); %SINR
            x.cell(7,:)=x.cell(7,:)/6+0.5;
            x.cell(8,:)=((x.cell(6,:)-mean(x.cell(6,:)))/std(x.cell(6,:)));%POWER
            x.cell(8,:)=x.cell(8,:)/6+0.5;
            x.cell(9,:)=x.cell(7,index)+x.cell(8,index);
            x.FittnessVall=x.cell(7,index)+x.cell(8,index);
            x = rmfield(x,'numarical');
            NewUsersArray=[NewUsersArray,x];
        end
    end
    PopulationArray{1,k}=NewUsersArray;
end


Number_Of_genes=length(PopulationArray{1,1});
%%PopulationArray1=PopulationArray;

%% corssover

for jj=1:NumberOfItterations
    if(LoadBalancing==1)
    % % if we want to make with load balancing it will cost much time
        CellUsers={};
        for i=1:NumberOfPopulation
            CellUsers{i}=CellUsersOne;
        end
%         for ii=1:NumberOfPopulation
%             chromosome=PopulationArray{1,ii};
%             u=zeros(1,length(AllCellsArray(1,:)));
%             for i=1:length(AllCellsArray(1,:))
%                 CellToTest=AllCellsArray(1:3,i);
%                 for j=1:length(chromosome)
%                     CellToCompare=[chromosome(j).cell];
%                     BinaryArray=[chromosome(j).binary];
%                     for k=1:length(CellToCompare(1,:))
%                         if(CellToCompare(1,k)==CellToTest(1) && CellToCompare(2,k)==CellToTest(2) && CellToCompare(3,k)==CellToTest(3) && BinaryArray(k)==1)
%                             u(i)=u(i)+1;
%                         end
%                     end
%                 end
%             end
%             CellUsers{ii}=u;
%         end
        for i=1:NumberOfPopulation
            chromosome=PopulationArray{1,i};
            for k=1:length(chromosome)
                OnIndex=find([chromosome(k).binary]==1);
                CellUsers{i}(OnIndex)=CellUsers{i}(OnIndex)+1;
                AllIndexes=[];
                numberOfUsers=[];
                for j=1:length([chromosome(k).cell(1,:)])
                    [cell,index]=FindCell(AllCellsArray,[chromosome(k).cell(1:3,j)]);
                    AllIndexes(j)=index;
                    numberOfUsers(j)=CellUsers{i}(index);
                end
                SINR=chromosome(k).cell(5,:);
                Power=chromosome(k).cell(6,:);
                SINR_WITH_USERS=SINR./(numberOfUsers+1);
                POWER_WITH_USERS=Power./(numberOfUsers+1);
                SINR_NORMALIZED=(SINR_WITH_USERS-mean(SINR_WITH_USERS))/std(SINR_WITH_USERS);
                SINR_NORMALIZED=SINR_NORMALIZED/6+0.5;
                POWER_NORMALIZED=(POWER_WITH_USERS-mean(POWER_WITH_USERS))/std(POWER_WITH_USERS);
                POWER_NORMALIZED=POWER_NORMALIZED/6+0.5;
                chromosome(k).FittnessVall=SINR_NORMALIZED(OnIndex)+POWER_NORMALIZED(OnIndex);
            end
            PopulationArray{1,i}=chromosome;
        end
    % % if we want to make with load balancing it will cost much time
    end
    
    
    for i=1:NumberOfPopulation
        PopulationArray{2,i}=sum([PopulationArray{1,i}.FittnessVall]);
    end
%     [val,in]=min([PopulationArray{2,:}]);
%     for i=1:NumberOfPopulation
%         PopulationArray{2,i}=PopulationArray{2,i}+abs(val);
%     end
    Sum=sum([PopulationArray{2,:}]);
    PopulationArray{3,1}=vpa(PopulationArray{2,1}/Sum,decimalPoints);
    PopulationArray{4,1}=sum([PopulationArray{3,1}]);
    for i=2:NumberOfPopulation
        PopulationArray{3,i}=vpa(PopulationArray{2,i}/Sum,decimalPoints);
        PopulationArray{4,i}=sum([PopulationArray{3,1:i}]);
    end
    
    if(jj<NumberOfItterations*0.8)
    PopulationArray1(jj,:)=[PopulationArray{2,:}]*(0.8+jj/(NumberOfItterations*10));
    reminder=jj;
    else
    PopulationArray1(jj,:)=[PopulationArray{2,:}]*(0.8+reminder/(NumberOfItterations*10));
    end
    
    MattingArray1={};
    MattingArray2={};
    for i=1:NumberOfPopulation
        randomNumber=rand(1);
        for k=1:NumberOfPopulation
            if(randomNumber<PopulationArray{4,k})
                temp=k;
                break;
            end
        end
        if(i<=NumberOfPopulation/2)
            MattingArray1(:,i)=PopulationArray(:,temp);
        else
            MattingArray2(:,mod(i,(NumberOfPopulation/2)+1)+1)=PopulationArray(:,temp);
        end
    end
    CrossOverArray={};
    
    for i=1:NumberOfPopulation/2
        Number_of_genes_for_crossOver=ceil(Number_Of_genes*rand(1));
        CrossOverGenes=randperm(Number_Of_genes,Number_of_genes_for_crossOver);
        firstChromosome=MattingArray1{1,i};
        secondChromosome=MattingArray2{1,i};
        for k=1:Number_of_genes_for_crossOver
            [firstChromosome(CrossOverGenes(k)), secondChromosome(CrossOverGenes(k))] = deal(secondChromosome(CrossOverGenes(k)),firstChromosome(CrossOverGenes(k)));
        end
        CrossOverArray{2*i-1}=firstChromosome;
        CrossOverArray{2*i}=secondChromosome;
    end
    % %mutation
    randomNumMutation=rand(1);
    if(randomNumMutation<Probability.mutation)
        Number_of_genes_for_Mutation=ceil(Number_Of_genes*rand(1));
        MutationGenes=randperm(Number_Of_genes,ceil(Number_of_genes_for_Mutation*MutationPercentage));
        if(rand(1)>0.5)
            for kk=1:length(MutationGenes)
                lengthGene=length(firstChromosome(1,MutationGenes(kk)).binary);
                oneIndex=find(firstChromosome(1,MutationGenes(kk)).binary,1);
                while(1)
                    changedOne=ceil(lengthGene*rand(1));
                    if(changedOne~=oneIndex)
                        break;
                    end
                end
                firstChromosome(1,MutationGenes(kk)).binary(oneIndex)=0;
                firstChromosome(1,MutationGenes(kk)).binary(changedOne)=1;
                firstChromosome(1,MutationGenes(kk)).cell(9,changedOne)=firstChromosome(1,MutationGenes(kk)).cell(7,changedOne)+firstChromosome(1,MutationGenes(kk)).cell(8,changedOne);
                firstChromosome(1,MutationGenes(kk)).FittnessVall=firstChromosome(1,MutationGenes(kk)).cell(9,changedOne);
            end
        else
            
            for kk=1:length(MutationGenes)
                lengthGene=length(secondChromosome(1,MutationGenes(kk)).binary);
                oneIndex=find(secondChromosome(1,MutationGenes(kk)).binary,1);
                while(1)
                    changedOne=ceil(lengthGene*rand(1));
                    if(changedOne~=oneIndex)
                        break;
                    end
                end
                secondChromosome(1,MutationGenes(kk)).binary(oneIndex)=0;
                secondChromosome(1,MutationGenes(kk)).binary(changedOne)=1;
                secondChromosome(1,MutationGenes(kk)).cell(9,changedOne)=secondChromosome(1,MutationGenes(kk)).cell(7,changedOne)+secondChromosome(1,MutationGenes(kk)).cell(8,changedOne);
                secondChromosome(1,MutationGenes(kk)).FittnessVall=secondChromosome(1,MutationGenes(kk)).cell(9,changedOne);
            end
            
        end
        
    end
    % %end of mutation
    
    
    PopulationArray=CrossOverArray;
end
%% final result
for i=1:NumberOfPopulation
    PopulationArray{2,i}=vpa(sum([PopulationArray{1,i}.FittnessVall]),decimalPoints);
end
Sum=vpa(sum([PopulationArray{2,:}]),decimalPoints);
PopulationArray{3,1}=vpa(PopulationArray{2,1}/Sum,decimalPoints);
PopulationArray{4,1}=sum([PopulationArray{3,1}]);
for i=2:NumberOfPopulation
    PopulationArray{3,i}=vpa(PopulationArray{2,i}/Sum,decimalPoints);
    PopulationArray{4,i}=sum([PopulationArray{3,1:i}]);
end
result=vpa(PopulationArray1(NumberOfItterations,:))
[res,ind]=max(result);
initial=vpa(PopulationArray1(1,:))
resultArray=PopulationArray{1,ind};

for i=1:length(geneticsUsers)
    index=find(resultArray(i).binary,1);
    geneticsUsers(i).CellConnectingTo=resultArray(i).cell(1:3,index);
    geneticsUsers(i).SINR=resultArray(i).cell(5,index);
    geneticsUsers(i).powerRecived=resultArray(i).cell(6,index);
end


