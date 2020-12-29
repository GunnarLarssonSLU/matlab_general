function [coords]=rotateGeomtetry(coords,angle)
%ROTATEGEOMETRY Rotate coords angle radians around origo

rotMatrix=[cos(angle) -sin(angle);sin(angle) cos(angle)];
coords=coords*rotMatrix;