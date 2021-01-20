const sdpTransform = require('sdp-transform');
module.exports = function streamConverter(payload) {
  const log = payload.logger;
  //log.info(`streamConverter: caller: ${payload.caller} -> callee: ${payload.callee} - `
  //    + `rec-id: ${payload.recId} - orig-sip-id: ${payload.originalCallId}`);
  //   + `rtpengineCalleeSdp: ${payload.sdp}`);


  payload.callerMedia = {audio: {}, video:{}};
  sdpTransform.parse(payload.callerSdp).media.forEach((m) => {
    //log.info(`media: ${m.type}, port: ${m.port} -> codec: ${m.rtp[0].codec} / ${m.rtp[0].rate}`);
    const media = payload.callerMedia[m.type];
    media.codec = m.rtp[0].codec;
    media.rate = m.rtp[0].rate;
    media.payload = m.rtp[0].payload;
    media.port = m.port;
  });
  payload.calleeMedia = {audio: {}, video:{}};
  sdpTransform.parse(payload.calleeSdp).media.forEach((m) => {
    //log.info(`media: ${m.type}, port: ${m.port} -> codec: ${m.rtp[0].codec} / ${m.rtp[0].rate}`);
    const media = payload.calleeMedia[m.type];
    media.codec = m.rtp[0].codec;
    media.rate = m.rtp[0].rate;
    media.payload = m.rtp[0].payload;
    media.port = m.port;
  });
  payload.callerSdp = null;
  payload.calleeSdp = null;
  log.info(payload);
};
