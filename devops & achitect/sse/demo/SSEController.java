package com.escher.digital.server.controller;

import com.escher.digital.server.utils.ConversionUtil;
import com.escher.digital.server.utils.SerialNumberUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.time.LocalTime;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

/**
 * 〈〉
 *
 * @author Hsiong
 * @version 1.0.0
 * @since 2023/7/28
 */
@Api(tags = {"SSE服务端"})
@RestController
@RequestMapping("/sse")
@CrossOrigin
public class SSEController {

    // 存放 SSE 客服端
    public static final ConcurrentHashMap<String, SseEmitter> SSE_EMITTER_CONCURRENT_HASH_MAP = new ConcurrentHashMap<>();

    // 异步线程
    private final ExecutorService executorService = Executors.newCachedThreadPool();


    @ApiOperation("获取sessionId")
    @GetMapping("/getSessionId")
    public String getSessionId() {
        String sessionId = ConversionUtil.encode10To62(SerialNumberUtil.next());
        return sessionId;
    }

    /**
     * 第2步：接受用户建立长连接，表示该用户已支付，已支付就可以生成订单(未确认状态)
     *
     * @param sessionId
     * @return
     */
    @ApiOperation("建立长连接")
    @GetMapping("/connect")
    public SseEmitter connect(@RequestParam(name = "sessionId", required = true) String sessionId) {
        //设置默认的超时时间60秒，超时之后服务端主动关闭连接。
        SseEmitter emitter = SSE_EMITTER_CONCURRENT_HASH_MAP.get(sessionId);
        if (ObjectUtils.isNotEmpty(emitter)) {
            return emitter;
        }
        emitter = new SseEmitter(60 * 1000L);
        SSE_EMITTER_CONCURRENT_HASH_MAP.put(sessionId, emitter);
        emitter.onTimeout(() -> SSE_EMITTER_CONCURRENT_HASH_MAP.remove(sessionId));

        executorService.execute(() -> {
            SseEmitter sseEmitter = SSE_EMITTER_CONCURRENT_HASH_MAP.get(sessionId);
            if (ObjectUtils.isNotEmpty(sseEmitter)) {
                try {
                    // 模拟发送消息
                    for (int i = 0; i < 10; i++) {
                        SseEmitter.SseEventBuilder sseEventBuilder = null;
                        if (i != 9) {
                            sseEventBuilder = SseEmitter.event()
                                                        .id(String.valueOf(System.currentTimeMillis()))
                                                        .data("server time: " + LocalTime.now().toString() + " id: " + sessionId);
                        } else {
                            sseEventBuilder = SseEmitter.event()
                                                        .name("finish")
                                                        .id(String.valueOf(System.currentTimeMillis()))
                                                        .data("server time: " +
                                                              LocalTime.now().toString() +
                                                              " 结束: " +
                                                              sessionId);
                        }

                        System.out.println("向客户端" + sessionId + "发送消息");
                        sseEmitter.send(sseEventBuilder);
                        TimeUnit.SECONDS.sleep(1);
                    }
                    
                } catch (Exception e) {
                    // 客户端接收异常
                    sseEmitter.completeWithError(e);
                } finally {
                    // this should not be used after container related events such as an error while sending.
                    sseEmitter.complete();
                    SSE_EMITTER_CONCURRENT_HASH_MAP.remove(sessionId);
                }


            }
        });

        return emitter;
    }


}
