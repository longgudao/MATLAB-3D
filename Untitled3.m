clear all;close all;
%% ��ȡͼ��
%i = rgb2gray(imread('ͼ1.jpg'));
i = rgb2gray(imread('E:\���ڼ�����ѧ����\��Ŀ����\�����л����о�ר���ص���Ŀ-\�걨����\�������ṩ�ο�\����ʦ�ο�����\����ʦ�ο�����\��������\ԭͼ\003.jpg'));
%i = imread('E:\���ڼ�����ѧ����\��Ŀ����\�����л����о�ר���ص���Ŀ-\�걨����\�������ṩ�ο�\����ʦ�ο�����\����ʦ�ο�����\��������\ԭͼ\014.jpg');
figure(1)
%subplot(221),imshow(i,[]),title('ԭͼ')
imshow(i),title('ԭͼ'),hold on
n = 1;
for ii = 1:size(i,1)
    for jj = 1:size(i,2)
        if ii-n<1||ii+n>size(i,1)||jj-n<1||jj+n>size(i,2)
            continue;
        end
        aa = i(ii-n:ii+n,jj-n:jj+n);
        %[x y] = find(aa==max(max(aa)));
        if  aa(n+1,n+1) == max(max(aa)) && i(ii,jj)>=15
            plot(jj,ii,'*r');
            a_max = max(max(aa));
            aa(n+1,n+1) = 0;
            [x y] = find((a_max-aa)<=5);
            plot(jj+y-(n+1),ii+x-(n+1),'*g');
%             if  aa(x,y) - i(ii,jj)<5 
%                 plot(jj+y-(n+1),ii+x-(n+1),'*g');
%             end 
        end 

%         for mm = -n:n
%             for nn = -n:n
%                 if ii+mm<1 || ii+mm>size(i,1)
%                     continue;
%                 end
%                 if jj+nn<1 || jj+nn>size(i,2)
%                     continue;
%                 end
%                 [x y] = find(a==max(max(a)))
%                 if res(ii,jj)<i(ii,jj) 
%                     res(ii,jj) = i(ii,jj);
%                 end
%             end
%         end 
 %       res0(ii,jj) = res(ii,jj) - i(ii,jj);
        %res(ii,jj) = (i(ii,jj)+res(ii,jj))/2;
    end
end
figure(6),imshow(res,[]),title('�˲�����2')

i_fft = fftshift(fft2(i));
subplot(222),imshow(abs(log10(abs(i_fft)+1)),[]),title('ԭͼ��ӦƵ��')
%% ����Ƶ���˹��ͨ�˲�
% x = linspace(-23,24,size(i,1));
% y = linspace(-31,32,size(i,2));
x = linspace(-26,26,size(i,1));
y = linspace(-26,26,size(i,2));
[X,Y] = meshgrid(y, x);
D=sqrt(X.^2+Y.^2);
D0=0.1*35;
H=exp(-(D.^2)/(2*(D0)^2));

%% �˲����
res_fft = i_fft.*H;
subplot(223),imshow(abs(log10(abs(res_fft)+1)),[]),title('�˲���Ƶ��')
res = ifft2(fftshift(res_fft));
subplot(224),imshow(res,[]),title('�˲�����');
figure,imshow(res,[]),title('�˲�����')
figure,imshow(i,[]),title('ԭͼ')
res0 = round(real(res));
res0 = res0./254;
% for n = 1:10
% for ii = 1:size(i,1)
%     for jj = 1:size(i,2)
%         if res(ii,jj)<i(ii,jj) 
%             res(ii,jj) = i(ii,jj);
%         end
%         res0(ii,jj) = res(ii,jj) - i(ii,jj);
%         %res(ii,jj) = (i(ii,jj)+res(ii,jj))/2;
%     end
% end
% end
% 
% figure(10),imshow(res,[]),title('�˲�����2')
% figure(11),imshow(res0,[]),title('��ֵ')
imwrite(res0,'res.jpg');