function [StructOut]=MultiplyStruct(StructIn,factor)
%MULTIPLYSTRUCT Multiplies the values of a struct (StructIn) with a chosen
%number (factor)

names=fieldnames(StructIn);
iItems=length(names);
StructOut=struct();
for iCounter=1:iItems
    txtClass=class(StructIn.(names{iCounter}));
    switch(txtClass)
        case 'struct'
            StructOut.(names{iCounter})=MultiplyStruct(StructIn.(names{iCounter}),factor);
        case 'double'
            StructOut.(names{iCounter})=StructIn.(names{iCounter})*factor;
        otherwise
            StructOut.(names{iCounter})=nan;
    end
end
