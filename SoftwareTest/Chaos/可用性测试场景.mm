
<map>
  <node ID="root" TEXT="可用性测试场景">
    <node TEXT="集群" ID="d7a7a503302bcfe1a8b54aa3bc753773" STYLE="bubble" POSITION="right">
      <node TEXT="开关机" ID="4ba732ab7401601b952aeca4e034b027" STYLE="fork"/>
      <node TEXT="Cpu" ID="676c0bb57654eb57550183473d6deaf0" STYLE="fork"/>
      <node TEXT="Men" ID="c22ce32709d7def788ddc387caa2d5af" STYLE="fork"/>
      <node TEXT="Disk" ID="97f6fc1bf659cad7a38182b656188c1f" STYLE="fork"/>
      <node TEXT="IO" ID="9ee3b61be25acc3dabd02a6f65b81787" STYLE="fork"/>
    </node>
    <node TEXT="中间件" ID="36f13e371712413f4aca49e9c338494c" STYLE="bubble" POSITION="right">
      <node TEXT="mysql" ID="cbc895eafa7e61d3583f3d6b5bc01f26" STYLE="fork">
        <node TEXT="停服重启" ID="777618fcc8fc857a0e67f5fee56cee1b" STYLE="fork"/>
        <node TEXT="主备切换" ID="112e3a561ce984e3c7dd170ce55349f6" STYLE="fork"/>
        <node TEXT="连接数满" ID="ca42594f93653ba4ba0e154546108c61" STYLE="fork"/>
        <node TEXT="网络延迟" ID="9847cffaae0103373d3591fb80f4ccb8" STYLE="fork"/>
        <node TEXT="cpu负载高" ID="f95bf14a68f71a213a653f6a72c4447d" STYLE="fork"/>
        <node TEXT="内存负载高" ID="44337bbc981ae8d8055fcac82c4b2e97" STYLE="fork"/>
        <node TEXT="杀node" ID="674a362bf270771f3de9e34353308d73" STYLE="fork"/>
      </node>
      <node TEXT="postgresql" ID="6f99c8c1e788d8873285f09af500e456" STYLE="fork">
        <node TEXT="停服重启" ID="09e69b15cd85ba79d338521f6f25e455" STYLE="fork"/>
        <node TEXT="连接数满" ID="f81834264d3cca9ac6791c1af4fda33e" STYLE="fork"/>
        <node TEXT="cpu负载高" ID="65304d226f34387f0f9b3c8e9eeb3c62" STYLE="fork"/>
        <node TEXT="内存负载高" ID="c5febd3b2680a0abba1ec73bcdcded60" STYLE="fork"/>
        <node TEXT="杀node" ID="bc340ec1d229c2d57b87e6b671aeee07" STYLE="fork"/>
      </node>
      <node TEXT="redis" ID="d4ba2f08638ff9462f2bb1cf9ab3cc0e" STYLE="fork">
        <node TEXT="停服重启" ID="c9bee49eb18d36f81cc7de07bd511d80" STYLE="fork"/>
        <node TEXT="重选主" ID="a49568c032dd232c2faf1a55bf664499" STYLE="fork"/>
        <node TEXT="连接数满" ID="0dc27a91079880bf4d2b2225a9f8b5ce" STYLE="fork"/>
        <node TEXT="cpu负载高" ID="37ce0e5b8630f25aafca5dc21a776fdf" STYLE="fork"/>
        <node TEXT="内存负载高" ID="4cd0dbb30782ea58b617a76e0235e098" STYLE="fork"/>
        <node TEXT="杀pod" ID="1c515e0502d0cb0b26d3d36a0d6fca66" STYLE="fork"/>
        <node TEXT="杀node" ID="2e05c274e7e0d4b7fe91cf88636d833e" STYLE="fork"/>
      </node>
      <node TEXT="minio" ID="c1b3835a29046d7c98082fb62cf8b6f9" STYLE="fork">
        <node TEXT="停服重启" ID="e7845e321db72af9772dedda93c3febd" STYLE="fork"/>
        <node TEXT="磁盘负载高" ID="e13e10615c7a59865da26dac1a78110c" STYLE="fork"/>
        <node TEXT="磁盘满" ID="12ac00c523c9486fc0b49a544a29d393" STYLE="fork"/>
        <node TEXT="cpu负载高" ID="4c990e19b3b733be90dbcce5ad464c48" STYLE="fork"/>
        <node TEXT="内存负载高" ID="90054155c08a8cb176456c95512b4b80" STYLE="fork"/>
        <node TEXT="杀pod" ID="37ff66a7ee5e36912ce9ea1a02482ea3" STYLE="fork"/>
        <node TEXT="杀node" ID="69a20e0ec9828f2be5732cf399de637f" STYLE="fork"/>
      </node>
      <node TEXT="zookeeper" ID="3f3553599830e6a52397acc1f831d1f4" STYLE="fork">
        <node TEXT="停服重启" ID="c6beab361fb0848e46dc47249b658cc2" STYLE="fork"/>
        <node TEXT="重选主" ID="8c9c0d8bdb46417fac6e995d4446da0f" STYLE="fork"/>
        <node TEXT="cpu负载高" ID="9d3244306988dfc9388bb90561515b1a" STYLE="fork"/>
        <node TEXT="内存负载高" ID="5211e84cf39d7b3d25ceb5c0433dcc19" STYLE="fork"/>
        <node TEXT="杀pod" ID="53ff0c24866107a1b6d861517ff0c69f" STYLE="fork"/>
        <node TEXT="杀node" ID="16877a7477c12bf22f4dfb753fdb82ce" STYLE="fork"/>
      </node>
      <node TEXT="kafka" ID="6a2caba1b65d187372aac80b35452fdc" STYLE="fork">
        <node TEXT="停服重启" ID="1bc71f6153d280c50dfb15e77bfcf936" STYLE="fork"/>
        <node TEXT="重选主" ID="e8a4c5adef01c47235b46d300517d2c7" STYLE="fork"/>
        <node TEXT="cpu负载高" ID="e490707193b2a1ac177d454673aa6694" STYLE="fork"/>
        <node TEXT="内存负载高" ID="4a1b587edef36a73ab543083a17be50d" STYLE="fork"/>
        <node TEXT="杀pod" ID="aa86733b418a457d17f2217bca3a9370" STYLE="fork"/>
        <node TEXT="杀node" ID="826a3d976ef1cd5661393007a3bbb981" STYLE="fork"/>
      </node>
      <node TEXT="elasticsearch" ID="71f3709b4217a76b8fef42fdaf88e715" STYLE="fork">
        <node TEXT="停服重启" ID="3a17c9c8e1c66a453259de352db08ec8" STYLE="fork"/>
        <node TEXT="重选主" ID="8756c4cb290ab9092fa9b3fc37bf18c5" STYLE="fork"/>
        <node TEXT="cpu负载高" ID="7f8a1143a39d2e853e63e399f63bae80" STYLE="fork"/>
        <node TEXT="内存负载高" ID="8e4d03ac3f60025ba55471014ff56e73" STYLE="fork"/>
        <node TEXT="杀pod" ID="e2026fce3abb348e2c1089127f99d929" STYLE="fork"/>
        <node TEXT="杀node" ID="717418d018a9067cf256ef488656f986" STYLE="fork"/>
      </node>
    </node>
    <node TEXT="业务应用" ID="67e51241b7f319b96c9c2eb26471eab8" STYLE="bubble" POSITION="right">
      <node TEXT="通用故障场景" ID="ec937be212bdcb61ab1e4be29af0c85f" STYLE="fork">
        <node TEXT="副本异常" ID="ae48f3da05b5b3d8f3f3f3f252316105" STYLE="fork"/>
        <node TEXT="服务扩缩容验证" ID="b2e0253c1f893951d4c39b6a54b50960" STYLE="fork"/>
        <node TEXT="cpu负载高" ID="df4541b7e8e24d209c73008bef11f846" STYLE="fork"/>
        <node TEXT="内存负载高" ID="b63feef3ed88a2388a697e342298a5b4" STYLE="fork"/>
        <node TEXT="亲和性验证" ID="e2707109bd746c411046ae438bde12a2" STYLE="fork"/>
      </node>
    </node>
    <node TEXT="高可用和混沌测试的区别" ID="cc936908feef81068fe7653873e40036" STYLE="bubble" POSITION="right">
      <node TEXT="mysql" ID="7fbdf8002b0adc5618c9acfca5766a1b" STYLE="fork">
        <node TEXT="高可用" ID="8f858f3accc417dad466ac3ea61081e8" STYLE="fork">
          <node TEXT="pod反亲和性验证" ID="87578835208f788efbfcdc54c5827190" STYLE="fork"/>
          <node TEXT="主备切换，正常提供服务" ID="f42360f5df0df0195a8b34f08d1fb862" STYLE="fork"/>
          <node TEXT="重启/延迟重启验证" ID="7d551536d53a1ee103fd62c93d40670b" STYLE="fork"/>
          <node TEXT="mysql主备服务不可用，扩缩容pod，功能正常" ID="d6c27a9e4e0d46706a3128102c21dba2" STYLE="fork"/>
          <node TEXT="重连性验证" ID="3f45833407f7e2705fa26dd73eaf9eed" STYLE="fork"/>
        </node>
        <node TEXT="混沌测试" ID="8735729eacf8e36b1aff87f1a4c0f089" STYLE="fork">
          <node TEXT="node" ID="93d3cab20de37eb1c1d5c7ce80ddadab" STYLE="fork">
            <node TEXT="mysql-主所在node节点重启/关机" ID="d62b31d9a14fedce34778ee53e6bbe0c" STYLE="fork"/>
            <node TEXT="mysql-从所在node节点重启/关机" ID="6401efc32c29ba95f9cd1a223c52a164" STYLE="fork"/>
            <node TEXT="pod所在node节点cpu负载高" ID="aeb922a9d4e0f57a3324e510e2c666a2" STYLE="fork"/>
            <node TEXT="pod所在node节点内存负载高" ID="e545b371126cca035adf10bec32dc8dc" STYLE="fork"/>
            <node TEXT="pod所在node节点磁盘负载高" ID="5a6a5845c3628693946731348b6cd86c" STYLE="fork"/>
          </node>
          <node TEXT="pod" ID="b557ca4429fb53295e5af7a08f2b445c" STYLE="fork">
            <node TEXT="cpu故障" ID="749066ee980bc8e4da59e32be09422ea" STYLE="fork">
              <node TEXT="mysql-cpu负载高90%" ID="709881005e8c930613ff3a0e3acb4d69" STYLE="fork"/>
            </node>
            <node TEXT="mem故障" ID="7155ffc7c5cb1f7443c4929d5c961236" STYLE="fork">
              <node TEXT="mysql-mem负载高90%" ID="78326a3700b8e318245791f975032767" STYLE="fork"/>
            </node>
            <node TEXT="杀进程" ID="3345214a9467f9330611cae8882d086c" STYLE="fork"/>
          </node>
          <node TEXT="连接数" ID="0d04e094ad2297b69d0580de9f7e7b99" STYLE="fork">
            <node TEXT="连接数打满" ID="e2ee4950327fab3374d7a93753baaa8e" STYLE="fork"/>
            <node TEXT="cpu负载高90%+连接数高90%" ID="d6545166c4d87c990fe1f82d9d85ae72" STYLE="fork"/>
          </node>
          <node TEXT="主备网络延迟3秒" ID="bc7b196b8cc4c5a8f0c24b3dba81cac7" STYLE="fork"/>
          <node TEXT="监控报警" ID="13fd6d17d73443052d75d5aae1710749" STYLE="fork">
            <node TEXT="功能有效" ID="9144edcd6f3b72555590ec5563eb4e16" STYLE="fork"/>
            <node TEXT="合理性" ID="98778e4ecac84c00caf718d188275d82" STYLE="fork"/>
          </node>
        </node>
      </node>
    </node>
  </node>
</map>