const express = require("express");

const app = express();

app.listen(3000, () => console.log("3000번 포트 연결 중"));

const server = app.get("/", (_, res) => {
  res.send("DOCKEREKCOD");
});

// graceful shutdown
// - 서버 종료 시 발생할 수 있는 문제를 방지하기 위해 서버 종료 직전 미리 정의된 정리 작업을 수행하는 것
// - ex) db 연결된 상태라면 db 연결 해제
// - ex) 새로운 요청은 받지 않고 기존 요청만 마저 처리
// - ex) 로그 기록
// - SIGTERM: 시스템으로부터 종료 요청을 받는 경우 ex) 컨테이너 종료, 터미널 kill 명령어
// - SIGINT: 사용자가 ctrl + c를 눌렀을 때 받는 신호
process.on("SIGTERM", () => {
  server.close(() => {
    console.log("HTTP server closed");
  });
});

process.on("SIGINT", () => {
  server.close(() => {
    console.log("HTTP server closed");
  });
});
