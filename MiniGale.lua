-- >> MiniGale
-- >> For Dicebot by Gedel Queiroz
-- >> Latest update - 02/10/2023


betBank             = 1.5000001  -- Saldo inicial  
percentage          = 0.0003 -- Define a porcentagem basebet de uso da banca
basebet             = betBank * percentage -- Define a aposta base baseado no percentage
nextbet             = basebet -- Valor para a próxima aposta
stopLoss_Percentage = 0.3 -- Pare de apostar quando o saldo for 30% da banca do betBank
printStats          = 1 -- Imprime estatísticas a cada rodada
coinvalue           = 5.03 -- Valor da moeda em Real ($$) para 1 USDT
chance              = 50 -- Chance de ganhar definida como 50%
baseChance          = 50 -- Chance base de ganhar
percentageLoss      = 0.10 -- Aumenta a aposta em 10% quando perde
percentageWin       = 0.097 -- Diminui a aposta em -9.7% quando ganha


percentage            = 0.0004-- Meta de lucro da banca
META_Stop_percentage  = 5  -- Divide a meta em partes e reseta seed a cada parte de lucro
pause_META            = 30 -- Pausa de 30 segundos após bater a meta
metaProfits           = true -- Em true pausa as apostas por alguns seguindos apos atingir a meta
metaGoal              = 0 -- Guarda a meta parcial
metaGoal_acc          = 0 -- Guarda a meta acumulada
META                  = betBank * percentage -- Calcula o valor da meta
META_Stop             = META / META_Stop_percentage -- Calcula qndo atingiu a meta

stopLoss = betBank * stopLoss_Percentage
chance = 50 -- Chance de ganhar definida como 50%
baseChance = 50 -- Chance base de ganhar

betcount           = 0 -- O número total de apostas feitas.
bet_count          = 0 -- O número de apostas feitas.
resetseedCount     = 0 -- O número de vezes que a semente foi redefinida.
highestBet         = 0 -- A aposta mais alta já feita.
highestLosses      = 0 -- O número máximo de apostas consecutivas perdidas.
highestLossesAcc   = 0 -- O número máximo acumulado de apostas perdidas.
highestLossesValue = 0 -- O valor máximo acumulado de perdas.
highestProfit      = 0 -- O maior lucro já obtido
metaGoal_Check     = 0 -- Reseta a meta ao atingir a meta
metaSecurityCheck  = 0 -- Verifica se a soma das partes da meta é igual a meta acumulada
meta_acc           = 0 -- Guarda o valor d.
part_meta_acc      = 0 -- O número de partes da meta alcançadas.
loss_count         = 0 -- O número de apostas consecutivas perdidas.
win_count          = 0 -- O número de apostas consecutivas ganhas.


resetseed() -- Reseta a semente antes de iniciiar a partida
resetstats() -- Reseta o Stats do console antes de iniciar

function dobet()
    
    
   if (betBank <= stopLoss) then -- Verifica se atingiu o StopLoss
        stop()
        print("\n\n")
        print("ATINGIMOS O STOP LOSS!")
   -end


    betcount += 1
    bet_count += 1
    
    -- Verifica se a meta já foi alcançada
    if (metaGoal >= META) then

        ching()
        metabatida()
        session_timing()
    end

    if (win) then -- Verifica se ganhou a aposta
        
        win_count += 1
        highestLossesAcc = 0
        loss_count = 0
        
        -- Da uma pausa ao atingir parte da meta
        if (metaProfits) then
            if profit >= META_Stop then
                metaGoal += profit
                stopLoss = betBank * stopLoss_Percentage
                ching()
                timing()
            end
        end

        nextbet = nextbet - (nextbet * percentageLoss) -- Diminui a aposta em -9.7% quando ganha

        
            if (bets % printStats == 0) then
                notification()
            end
    
    else 
        
        highestLossesAcc = highestLossesAcc + previousbet
        if highestLossesAcc >= highestLossesValue then
            highestLossesValue = highestLossesAcc + highestLossesValue
        end
       
        nextbet = nextbet + (nextbet * percentageWin) -- Aumenta a aposta em 10% quando perde

        -- Verifica o máximo de loss       
    end    

    -- Condicionais para notificação

    if loss_count >= highestLosses then
        highestLosses = loss_count
    end

    if previousbet >= highestBet then
        highestBet = previousbet
    end

    if (profit >= highestProfit) then
        highestProfit = profit
    end

    if betBank <= 0 then stop() 
    end

    notification()

end
-- Funções

-- Meta Batida
function metaRestart()
    META = betBank * percentage
    META_Stop = META / META_Stop_percentage
end

-- Aguarda a pausa definida antes iniciar a próxima sessão
function session_timing()
    meta_acc += 1
    notification()
    metabatida()
    print("\n#=========================================#")
    print("-->> Voltamos em " ..tostring((pause_META/60)) .." minutos!")
    print("#=========================================#")
    resetstats()
    resetseedCount += 1
    resetseed()

    -- Redefine as variáveis de meta
    metaGoal_acc = metaGoal_acc + metaGoal
    metaSecurityCheck = metaGoal_acc
    metaGoal = 0
    part_meta_acc = 0
    metaRestart()

    -- Pausa de 60 segundos
    sleep(pause_META)

end

-- Aguarda antes de continuar apostando
function timing()
    
    part_meta_acc += 1
    notification()
    print("#============================================================#")
    print("-->> Parte " ..tostring(part_meta_acc) .." de " ..tostring(META_Stop_percentage) .." concluída." .. " Atualizando apostas...")
    print("-->> LUCRO: " ..string.format("%9.8f", profit) .. " " .. string.upper(currency))
    print("#============================================================#")
    resetstats()
    resetseed()
    sleep_timing = 3 -- Tempo de pausa entre 3 e 10 segundos
    sleep(sleep_timing)
    
end

-- Para as apostas ao bater a meta
function metabatida()
    
    print("#=========================================#")
    print("===>>> META " ..tostring(meta_acc) .." BATIDA!" )
    print("===>>> LUCRO: " ..string.format("%9.8f", metaGoal_acc) .. " " .. string.upper(currency))
    print("#=========================================#")
end

-- Exibe informações no console
function notification()
    print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
    print("#=========================================#")
    print("    #---===->>  MiniGale <<-===---#       ")
    print("#=========================================#")
    print("->> Lucro: "..string.format("%9.8f", profit))
    print("->> R$ Lucro: "..string.format("%.3f",(profit)*coinvalue))
    print("->> Restante: "..string.format("%9.8f", (META - profit)))
    print("---------------------------------------------")
    print("->> Stop Loss: "..string.format("%9.8f", stopLoss) .. " " .. string.upper(currency))
    print("")

    print("->> Highest Bet: "..string.format("%9.8f", highestBet) .. " " .. string.upper(currency))
    print("->> Highest Profit: "..string.format("%9.8f", highestProfit) .. " " .. string.upper(currency))
    print("->> Highest Loss: "..string.format("%9.8f", highestLossesValue) .. " " .. string.upper(currency))
    print("->> Highest Loss Seq: ".. highestLosses)
    print(string.format("->> Aposta: %.8f | Chance: %.2f | Bethigh: %s", nextbet, chance, tostring(bethigh)))
    print("")
    if (metaProfits) then
        print("# Meta do Dia: " .. string.format("%9.8f", META) .. " " .. string.upper(currency))
        print("# R$ Meta do Dia: "..string.format("%.3f",(META)*coinvalue))
        print("# Parte do Dia: " .. string.format("%9.8f", META_Stop) .. " " .. string.upper(currency))
        print("# Alcançado Hoje: " .. string.format("%9.8f", metaGoal) .. " " .. string.upper(currency))
        print("# Alcançado anteriormente: " .. string.format("%9.8f", metaGoal_acc) .. " " .. string.upper(currency))
        print("---------------------------------------------")
        print("Partes da meta: " ..tostring(part_meta_acc))
        print("Metas alcançadas: " ..tostring(meta_acc))
        print("")
    end
    print("-----------------------------------------")
    print("*By Gedel Queiroz dos Santos")
    print("\n\n")
end
