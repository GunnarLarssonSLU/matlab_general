function [StructOut]=AddStruct(Struct1,Struct2,txtPlusOrMinus)
%ADDSTRUCT Creates a structure contining the sum or different between
%Struct1 and Struct2

names=fieldnames(Struct1);
iItems=length(names);
StructOut=struct();

for iCounter=1:iItems
    txtClass=class(Struct1.(names{iCounter}));
    switch(txtClass)
        case 'struct'
            txtName=names{iCounter};
            if (~strcmp(txtName,'parts'))
                StructOut.(names{iCounter})=AddStruct(Struct1.(txtName),Struct2.(txtName),txtPlusOrMinus);
            end
        case 'double'
            switch(txtPlusOrMinus)
                case '+'
                    StructOut.(names{iCounter})=Struct1.(names{iCounter})+Struct2.(names{iCounter});
                case '-'
                    StructOut.(names{iCounter})=Struct1.(names{iCounter})-Struct2.(names{iCounter});
            end
        otherwise
            StructOut.(names{iCounter})=nan;
    end
end