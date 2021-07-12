fileID = fopen('output_pascalvoc.xml','w');
data_source = gTruth.DataSource.Source;
data_label = gTruth.LabelData;
n_labels = width(labeldata);
name_labels=gTruth.LabelData.Properties.VariableNames;
n_pictures = length(gTruth.DataSource.Source);
for i=1:n_pictures   
    fprintf(fileID,'<annotation> \n');
    filename=gTruth.DataSource.Source{i};
    fprintf(fileID,'\t <folder>2dimage_supsi</folder> \n');
    fprintf(fileID,'\t <filename>%s</filename> \n',filename);
    fprintf(fileID,'\t <path>%s</path> \n',filename);
    fprintf(fileID,'\t<source> \n');
	fprintf(fileID,'\t\t <database>Unknown</database> \n');
	fprintf(fileID,'\t</source> \n');
    A=imread(filename);
    A_dim = size(A);
    fprintf(fileID,'\t<size> \n');
    fprintf(fileID,'\t\t<width> %5d </width>\n',A_dim(1));
    fprintf(fileID,'\t\t<heigth>%5d </width>\n',A_dim(2));
    fprintf(fileID,'\t\t<depth> %5d </width>\n',A_dim(3));
    fprintf(fileID,'\t</size> \n');
    fprintf(fileID,'\t<segmented>0</segmented>\n');
    for j=1:n_labels
        x=data_label(i,j);
        y=table2array(x);
        k=y{1};
        l=size(k,1);
        if (l > 0)
         for h=1:l  
          fprintf(fileID,'\t<object>\n');
          fprintf(fileID,'\t\t<name>%s</name>\n',name_labels{j});
          fprintf(fileID,'<pose>Unspecified</pose> \n');
		  fprintf(fileID,'<truncated>0</truncated> \n');
		  fprintf(fileID,'<difficult>0</difficult> \n');
          fprintf(fileID,'\t\t<bndbox> \n');
          fprintf(fileID,'\t\t\t<xmin>%d</xmin>\n',k(h,1));
          fprintf(fileID,'\t\t\t<ymin>%d</ymin>\n',k(h,2));
          fprintf(fileID,'\t\t\t<xmax>%d</xmax>\n',k(h,1)+k(h,3));
          fprintf(fileID,'\t\t\t<ymax>%d</ymax>\n',k(h,2)+k(h,4));
          fprintf(fileID,'\t\t</bndbox> \n');
          fprintf(fileID,'\t</object>\n');
         end
        end
    end
    fprintf(fileID,'</annotation> \n');
end
fclose(fileID);