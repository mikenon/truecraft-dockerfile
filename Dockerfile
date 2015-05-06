FROM mono:4.0.0-onbuild
EXPOSE 25565
CMD [ "mono",  "./TrueCraft.exe" ]
