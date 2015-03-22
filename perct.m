function perct(t,x,y)
% Show the program procedure and time remained.
% When the program is ended, output the total time elapsed (.0000 hours).
% You had better to save the elapsed time using "time=toc/3600" after the 
% loops are completed.
% 
% Input:
%     t is time elapsed (seconds) which is record by "tic" and "toc"
%     x of y loops have completed

%     2DPCA with L1-norm for simultaneously robust and sparse modelling
%     Copyright (C) <2013>  <Jing Wang>
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

% percentage
fprintf('The program has run: %0.2f%%\n', x*100/y);

% time remaining
tm=t*(y-x)/x; 

% time scale: h, m, s
if tm>60*60
    h=floor(tm/(60*60)); 
    m=floor(tm/60-h*60);
    fprintf('Remaining time: %d hours %d minutes.',h,m);
elseif tm>60
    m=floor(tm/60); 
    s=floor(tm-m*60);
    fprintf('Remaining time: %d minutes %d seconds.',m,s);
elseif tm>0
    s=floor(tm);
    fprintf('Remaining time: %d seconds.',s);
else % tm=0
    h=t/(60*60);
    fprintf('Total time elapsed: %0.4f hours.',h);
end
fprintf('\n\n');