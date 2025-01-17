# Dockerfile: 프로그램을 실행하는 데에 필요한 명령어들을 기입하는 곳임. 이미지 만들 때 사용하는 설명서라고 보면 됨
# - Dockerfile에 작성한 명령어는 순차적으로 실행됨
# - COPY, RUN 이런 명령어들이 실행되면 그 결과는 알아서 캐싱됨
# - 이후 이미지 빌드 시, 변동된 사항이 없다면 캐싱된 값을 그대로 사용
# - 따라서 변동사항이 적은 파일을 다루는 명령어는 아래쪽에 작성해줘야 이미지 빌드가 빨리 됨

# FROM: 도커 파일의 시작점
# - 특정 이미지를 불러와서 그 이미지의 완성된 내용을 바탕으로 시작하는거임 
# - 객체 지향 프로그래밍의 상속이랑 비슷한 개념이라고 보면 될듯
FROM node:20-slim

# WORKDIR: 이미지의 작업 디렉토리를 설정
# - 디렉토리가 없으면 새로 생성
# - 생성과 동시에 해당 디렉토리로 이동
# - cd 명령어하고 비슷한 느낌
WORKDIR /app 

# COPY: 현재 내 컴퓨터의 파일을 생성될 이미지에 복사하고 싶을 때 사용하는 명령어 
# - COPY [호스트 경로] [이미지의 작업 디렉토리] 
COPY package*.json .

# RUN: 터미널 명령어를 실행시키고 싶을 때 사용
# - 이미지 빌드 단계에서 실행되는 명령어 
# npm ci
# - 라이브러리들의 버전이 정확하게 명시된 packge-lock.json에 따라서 라이브러리 설치
# - 'npm install'은 package.json을 참고해서 라이브러리들을 설치하는데, 이 파일의 dependency 버전들은 기본적으로 '4.*'처럼 앞 자리만 확인하기 때문에 정확한 버전이 설치되지 않을 수 있음
RUN ["npm", "ci"]

# ENV: 환경변수를 설정할 수 있게 해주는 명령어
ENV NODE_ENV=production

COPY . .

# EXPOSE: 몇 번 포트를 사용할 지 명시해두는 용도 
EXPOSE 3000

# USER: 컨테이너 내부의 사용자 계정을 설정
# - 보안 상의 문제로 사용하는 명령어 
# - Dockerfile에 작성된 명령어들은 기본적으로 root 권한으로 실행되는데, 이는 나중에 컨테이너가 탈취 당했을 때 호스트 시스템 전체가 위험에 처해질 수 있음
# - 실행 직전에 USER 명령어로 비권한 사용자를 설정하여 접근 권한을 낮춰준다면, 이러한 보안 문제를 어느정도 보완해줄 수 있음
USER node

# CMD: 마지막 터미널 명령어일 경우에은 RUN 대신 CMD를 사용
# - 빌드 완료 후, 최종적인 실행 단계에서 실행되는 명령어 
# - 비슷한 걸로 ENTRYPOINT 명령어가 있는데, 차이점은 명령어를 덧씌워서 사용할 수 있냐 없냐의 차이 (CMD O, ENTRYPOINT X)
CMD ["node", "index.js"]


