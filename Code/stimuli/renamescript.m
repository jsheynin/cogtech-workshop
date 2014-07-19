d='/Users/Jacob/Documents/Work and Research/Berkeley Silver Lab/Absolute Pitch/violin/';
d_new='/Users/Jacob/Documents/Work and Research/Berkeley Silver Lab/Absolute Pitch/Timbre Tones/';
names = dir(d);
names = {names(~[names.isdir]).name};
names=names(2:end);

for i=1:numel(names)
   oldname= [d names{i}];
   
   newname=[d_new names{i}(1:6) '.' names{i}(7:end) ];
   movefile(oldname, newname)
end

   